(define (maximum-importance n roads)
  (let* ((degrees (make-vector n 0))
         (adj (for/list ((road roads))
                (let ((u (first road))
                      (v (second road)))
                  (begin
                    (vector-set! degrees u (+ (vector-ref degrees u) 1))
                    (vector-set! degrees v (+ (vector-ref degrees v) 1))))))
         (sorted-degrees (sort (vector->list degrees) >))
         (importance (make-hash)))
    (for ((i (in-range n)))
      (hash-set! importance (list-ref sorted-degrees i) (+ i 1)))
    (foldl + 0
           (map
            (lambda (road)
              (+ (hash-ref importance (vector-ref degrees (first road)))
                 (hash-ref importance (vector-ref degrees (second road)))))
            roads))))