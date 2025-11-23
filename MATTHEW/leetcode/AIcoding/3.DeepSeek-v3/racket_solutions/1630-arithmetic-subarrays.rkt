(define/contract (check-arithmetic-subarrays nums l r)
  (-> (listof exact-integer?) (listof exact-integer?) (listof exact-integer?) (listof boolean?))
  (define (is-arithmetic? sub)
    (let* ([sorted (sort sub <)]
           [diff (- (second sorted) (first sorted))])
      (for/and ([i (in-range 1 (sub1 (length sorted)))])
        (equal? diff (- (list-ref sorted (add1 i)) (list-ref sorted i))))))

  (for/list ([left l] [right r])
    (is-arithmetic? (take (drop nums left) (+ 1 (- right left))))))