(define (maximum-beauty items)
  (foldl (lambda (item max-b) (max max-b (cadr item))) 0 items))

(define (most-beautiful-item-for-each-query items queries)
  (let* ((sorted-items (sort items < #:key car))
         (prefix-max-beauty (make-vector (length sorted-items) 0)))
    (vector-set! prefix-max-beauty 0 (cadr (list-ref sorted-items 0)))
    (for ((i (in-range 1 (length sorted-items))))
      (vector-set! prefix-max-beauty i (max (vector-ref prefix-max-beauty (- i 1)) (cadr (list-ref sorted-items i)))))
    (map (lambda (query)
           (let loop ((low 0) (high (- (length sorted-items) 1)))
             (cond
               ((> low high) (if (= low 0) 0 (vector-ref prefix-max-beauty (- low 1))))
               (else
                (let ((mid (floor (/ (+ low high) 2))))
                  (if (<= (car (list-ref sorted-items mid)) query)
                      (loop (+ mid 1) high)
                      (loop low (- mid 1))))))))
         queries)))