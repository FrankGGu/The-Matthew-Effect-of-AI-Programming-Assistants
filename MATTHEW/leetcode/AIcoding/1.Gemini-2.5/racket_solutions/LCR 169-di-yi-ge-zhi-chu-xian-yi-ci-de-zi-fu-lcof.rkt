#lang racket

(define (solve s moves-list)
  ;; Pre-process moves for easier access and comparison.
  ;; Each move is transformed into a list: (list sequence-length name-string sequence-string).
  ;; The name-string is kept as a string (length 1) because it will be used directly
  ;; in string-append operations.
  (define processed-moves
    (map (lambda (move)
           (list (string-length (cadr move)) (car move) (cadr move)))
         moves-list))

  ;; The main loop that repeatedly finds and applies the best move until no more moves can be made.
  (let loop ((current-s s))
    (let ((best-match #f)) ; Stores (list start-index sequence-length name-string)

      ;; Iterate through all possible starting positions in the current string.
      (for ([i (in-range (string-length current-s))])
        ;; For each position, check all available special moves.
        (for ([move processed-moves])
          (let* ((seq-len (list-ref move 0))
                 (name-str (list-ref move 1))
                 (seq-str (list-ref move 2)))

            ;; Ensure the sequence can fit within the remaining part of the string.
            (when (<= (+ i seq-len) (string-length current-s))
              ;; Extract the substring to check for a match.
              (let ((sub-str (substring current-s i (+ i seq-len))))
                ;; If the substring matches a special move's sequence.
                (when (string=? sub-str seq-str)
                  ;; This is a potential match. Compare it with the current best match found so far.
                  (if (not best-match)
                      ;; If no best match yet, this is the first one.
                      (set! best-match (list i seq-len name-str))
                      ;; If a best match exists, apply tie-breaking rules.
                      (let* ((current-best-seq-len (list-ref best-match 1))
                             (current-best-name-str (list-ref best-match 2)))

                        ;; Tie-breaking rules:
                        ;; 1. The move with the longest sequence takes precedence.
                        ;; 2. If sequence lengths are tied, the one with the lexicographically smallest name takes precedence.
                        (when (or (> seq-len current-best-seq-len)
                                  (and (= seq-len current-best-seq-len)
                                       (string<? name-str current-best-name-str)))
                          (set! best-match (list i seq-len name-str))))))))))

      ;; After checking all possible matches, if a best match was found:
      (if best-match
          (let* ((start-idx (list-ref best-match 0))
                 (seq-len (list-ref best-match 1))
                 (name-str (list-ref best-match 2)))

            ;; Perform the replacement:
            ;; Concatenate the part of the string before the match, the name of the special move,
            ;; and the part of the string after the match.
            (let ((new-s (string-append (substring current-s 0 start-idx)
                                        name-str
                                        (substring current-s (+ start-idx seq-len) (string-length current-s)))))
              ;; Continue the loop with the modified string.
              (loop new-s)))
          ;; If no best match was found in this iteration, the process stops.
          ;; Return the final string.
          current-s))))