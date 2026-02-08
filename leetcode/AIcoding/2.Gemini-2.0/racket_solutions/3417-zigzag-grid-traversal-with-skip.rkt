(define (zigzag-traverse-with-skip grid skip)
  (define rows (length grid))
  (define cols (length (first grid)))
  (define result '())
  (define (valid? r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))
  (define (traverse r c up)
    (cond
      [(not (valid? r c))
       (if up
           (if (< c cols)
               (traverse r (add1 c) (not up))
               (traverse (add1 r) c (not up)))
           (if (< r rows)
               (traverse (add1 r) c (not up))
               (traverse r (add1 c) (not up))))]
      [(equal? (list r c) skip)
       (traverse (if up (sub1 r) (add1 r)) (if up (add1 c) (sub1 c)) up)]
      [else
       (set! result (append result (list (list r c))))
       (traverse (if up (sub1 r) (add1 r)) (if up (add1 c) (sub1 c)) up)]))
  (traverse 0 0 #t)
  result)