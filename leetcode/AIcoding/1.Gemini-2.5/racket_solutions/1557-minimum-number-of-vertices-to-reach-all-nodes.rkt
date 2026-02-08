(define (find-smallest-set-of-vertices n edges)
  (let* ([in-degrees (make-vector n 0)])
    (for-each (lambda (edge)
                (let ([to (cadr edge)])
                  (vector-set! in-degrees to (+ (vector-ref in-degrees to) 1))))
              edges)
    (for/list ([i (in-range n)]
               #:when (= (vector-ref in-degrees i) 0))
      i)))