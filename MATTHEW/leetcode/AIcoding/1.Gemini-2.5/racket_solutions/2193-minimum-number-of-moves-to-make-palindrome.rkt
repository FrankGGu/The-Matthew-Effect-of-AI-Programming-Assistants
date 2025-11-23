(define (min-moves-to-make-palindrome s)
  (let* ((n (string-length s))
         (v (list->vector (string->list s))))

    ;; Helper to find the rightmost occurrence of a character within a range [start-idx, end-idx]
    ;; Returns the index if found, otherwise -1.
    (define (find-rightmost-char-index vec char start-idx end-idx)
      (let loop ((i end-idx))
        (cond
          ((< i start-idx) -1) ; Not found
          ((char=? (vector-ref vec i) char) i)
          (else (loop (- i 1))))))

    ;; Helper to shift a character from from-idx to to-idx
    ;; Characters from (from-idx + 1) to to-idx are shifted one position to the left.
    (define (shift-char-to-right vec from-idx to-idx)
      (let ((char-to-move (vector-ref vec from-idx)))
        (for ((j (in-range from-idx to-idx)))
          (vector-set! vec j (vector-ref vec (+ j 1))))
        (vector-set! vec to-idx char-to-move)))

    ;; Main recursive loop
    (let loop ((left 0) (right (- n 1)) (current-moves 0))
      (if (>= left right)
          current-moves
          (cond
            ;; Characters match, move inwards
            ((char=? (vector-ref v left) (vector-ref v right))
             (loop (+ left 1) (- right 1) current-moves))
            ;; Characters don't match, find the pair for the left character
            (else
             (let ((k (find-rightmost-char-index v (vector-ref v left) (+ left 1) (- right 1))))
               ;; The problem guarantees that a palindrome can be formed and n is even.
               ;; This implies that for v[left], a matching character k must exist
               ;; within the range [left+1, right-1].
               ;; If k is not found, it would imply v[left] is a unique character
               ;; that should be in the middle, which is not possible for even length strings.
               (let ((swaps (- right k)))
                 (shift-char-to-right v k right)
                 (loop (+ left 1) (- right 1) (+ current-moves swaps))))))))))