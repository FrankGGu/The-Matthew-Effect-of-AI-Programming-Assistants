(define (find-smallest-set-of-vertices n edges)
  (let ((in-degree (make-vector n 0)))
    (for-each (lambda (edge)
                (let ((to (cadr edge)))
                  (vector-set! in-degree to (+ (vector-ref in-degree to) 1)))
              edges)
    (for/list ([i (in-range n)]
               #:when (zero? (vector-ref in-degree i)))
      i)))