(define (min-extra-char s dictionary)
  (define n (string-length s))
  (define dp (make-vector (+ n 1) 0))

  (define dict-set (make-hash))
  (for-each (lambda (word) (hash-set! dict-set word #t)) dictionary)

  (vector-set! dp 0 0)

  (for i (range 1 (+ n 1))
    (vector-set! dp i (+ 1 (vector-ref dp (- i 1))))

    (for j (range 0 i)
      (define current-word (substring s j i))
      (when (hash-has-key? dict-set current-word)
        (vector-set! dp i (min (vector-ref dp i) (vector-ref dp j))))))

  (vector-ref dp n))