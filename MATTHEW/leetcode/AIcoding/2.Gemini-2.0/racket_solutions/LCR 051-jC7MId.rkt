(define (max-path-sum root)
  (let ((max-sum (box -inf.0)))
    (define (max-gain node)
      (cond
        [(null? node) 0]
        [else
         (let ((left-gain (max 0 (max-gain (car node))))
               (right-gain (max 0 (max-gain (cdr node)))))
           (box-set! max-sum (max (unbox max-sum) (+ (car (car node)) left-gain right-gain)))
           (+ (car (car node)) (max left-gain right-gain)))]))
    (max-gain root)
    (unbox max-sum)))