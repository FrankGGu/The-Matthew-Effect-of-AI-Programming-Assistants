(define (shortest-and-lexicographically-smallest-beautiful-string s k target)
  (define (is-prime-digit? char-digit)
    (case char-digit
      ((#\2 #\3 #\5 #\7) #t)
      (else #f)))

  (define (char-digit->int char-digit)
    (- (char->integer char-digit) (char->integer #\0)))

  (define min-beautiful-string "")

  (define s-len (string-length s))

  (when (>= s-len k) ; Ensure k is not greater than s-len
    (for ([i (in-range 0 (+ (- s-len k) 1))]) ; Iterate through all possible starting indices
      (define current-substring (substring s i (+ i k)))

      (define beautiful?
        (let loop ([j 0] [current-sum 0])
          (cond
            [(= j k) ; All characters processed
             (= (modulo current-sum target) 0)] ; Check sum divisibility
            [else
             (define char-at-j (string-ref current-substring j))
             (if (is-prime-digit? char-at-j)
                 (loop (+ j 1) (+ current-sum (char-digit->int char-at-j)))
                 #f)]))) ; Not beautiful if non-prime digit found

      (when beautiful?
        (when (or (string=? min-beautiful-string "")
                  (string<? current-substring min-beautiful-string))
          (set! min-beautiful-string current-substring)))))

  min-beautiful-string)