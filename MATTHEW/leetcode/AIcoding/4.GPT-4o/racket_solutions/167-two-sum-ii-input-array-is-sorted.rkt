(define (two-sum numbers target)
  (define n (length numbers))
  (define left 0)
  (define right (sub1 n))
  (let loop ()
    (cond
      [(= (+ (list-ref numbers left) (list-ref numbers right)) target)
       (list (add1 left) (add1 right))]
      [(< (+ (list-ref numbers left) (list-ref numbers right)) target)
       (set! left (add1 left))
       (loop)]
      [else
       (set! right (sub1 right))
       (loop)])))

(two-sum (vector 2 7 11 15) 9)