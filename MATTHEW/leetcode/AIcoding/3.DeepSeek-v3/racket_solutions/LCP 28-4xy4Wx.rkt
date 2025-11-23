(define/contract (purchase-plans nums target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define sorted-nums (sort nums <))
  (define n (length sorted-nums))
  (define (count-pairs left right count)
    (cond
      [(>= left right) count]
      [else
       (define sum (+ (list-ref sorted-nums left) (list-ref sorted-nums right)))
       (if (> sum target)
           (count-pairs left (sub1 right) count)
           (count-pairs (add1 left) right (modulo (+ count (- right left)) 1000000007)))]))
  (count-pairs 0 (sub1 n) 0))