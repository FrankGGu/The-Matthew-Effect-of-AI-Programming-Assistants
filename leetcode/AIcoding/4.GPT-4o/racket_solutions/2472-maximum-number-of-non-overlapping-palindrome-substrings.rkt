(define (max-palindromes s k)
  (define n (string-length s))
  (define palindromes (make-vector n #f))

  (define (is-palindrome start end)
    (let loop ((left start) (right end))
      (if (or (< left 0) (>= right n) (not (char=? (string-ref s left) (string-ref s right))))
          (if (= left (+ right 1)) 1 0)
          (+ (loop (- left 1) (+ right 1)) 1))))

  (for ([i (in-range n)])
    (let ((odd-length (is-palindrome i i))
          (even-length (is-palindrome i (+ i 1))))
      (when (> odd-length 0) (vector-set! palindromes i odd-length))
      (when (> even-length 0) (vector-set! palindromes i even-length))))

  (define dp (make-vector (add1 n) 0))

  (for ([i (in-range n)])
    (for ([j (in-range (max 0 (- i k))) (in-range (add1 (min n (+ i k))))])
      (when (and (vector-ref palindromes j) (> (vector-ref palindromes j) 0))
        (set! dp (vector-set! dp (+ i 1) (max (vector-ref dp (+ i 1)) (+ 1 (vector-ref dp j))))))))

  (vector-ref dp n))

(max-palindromes "abacc" 3)