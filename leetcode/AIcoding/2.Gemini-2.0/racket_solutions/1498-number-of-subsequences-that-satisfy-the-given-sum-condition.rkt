(define (num-subsequences nums target)
  (define (pow-mod base exp mod)
    (cond
      [(= exp 0) 1]
      [(= (modulo exp 2) 0) (modulo (* (pow-mod base (/ exp 2) mod) (pow-mod base (/ exp 2) mod)) mod)]
      [else (modulo (* base (pow-mod base (- exp 1) mod)) mod)]))

  (define (solve sorted-nums target)
    (let loop ([l 0] [r (- (length sorted-nums) 1)] [count 0])
      (cond
        [(< l (length sorted-nums))
         (cond
           [(>= l r)
            (cond
              [(<= (+ (list-ref sorted-nums l) (list-ref sorted-nums l)) target)
               (add1 count)]
              [else count])]
           [else
            (if (<= (+ (list-ref sorted-nums l) (list-ref sorted-nums r)) target)
                (loop (add1 l) r (modulo (+ count (pow-mod 2 (- r l) 1000000007)) 1000000007))
                (loop l (- r 1) count))])
         ]
        [else count])))

  (solve (sort nums <) target))