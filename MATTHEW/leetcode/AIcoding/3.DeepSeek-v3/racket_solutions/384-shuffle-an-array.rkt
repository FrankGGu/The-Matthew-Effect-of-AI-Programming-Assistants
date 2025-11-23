(define (make-shuffer nums)
  (let ((original (list->vector nums))
        (current (list->vector nums)))
    (lambda (op)
      (case op
        [(reset) (vector-copy! current 0 original 0 (vector-length original))
                 (vector->list current)]
        [(shuffle) (for ([i (in-range (sub1 (vector-length current)) 0 -1)])
                    (let ([j (random (add1 i))])
                      (let ([tmp (vector-ref current i)])
                        (vector-set! current i (vector-ref current j))
                        (vector-set! current j tmp)))
                    (vector->list current)]
        [else (error "Unknown operation")]))))