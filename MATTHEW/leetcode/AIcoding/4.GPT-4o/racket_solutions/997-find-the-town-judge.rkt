(define (findTownJudge n trust)
  (define trust-count (make-vector (add1 n) 0))
  (define trusted-by (make-vector (add1 n) 0))

  (for-each (lambda (x)
              (vector-set! trust-count (car x) (+ 1 (vector-ref trust-count (car x))))
              (vector-set! trusted-by (cadr x) (+ 1 (vector-ref trusted-by (cadr x)))))
            trust)

  (for ([i (in-range 1 (+ 1 n))])
    (when (and (= (vector-ref trust-count i) 0)
               (= (vector-ref trusted-by i) (- n 1)))
      (return i)))

  -1)