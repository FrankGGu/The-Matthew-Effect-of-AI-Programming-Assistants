(define (rotate nums k)
  (let* ((n (length nums))
         (k (modulo k n)))
    (cond
      [(zero? k) nums]
      [else
       (append (list->vector (reverse (vector->list (vector-slice (list->vector nums) (- n k) n))))
               (list->vector (reverse (vector->list (vector-slice (list->vector nums) 0 (- n k))))))])))