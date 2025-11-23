(define/contract (two-sum price target)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (let loop ([i 0] [j (- (length price) 1)])
    (cond
      [(>= i j) '()]
      [(= (+ (list-ref price i) (list-ref price j)) target) (list (list-ref price i) (list-ref price j))]
      [(< (+ (list-ref price i) (list-ref price j)) target) (loop (+ i 1) j)]
      [else (loop i (- j 1))])))