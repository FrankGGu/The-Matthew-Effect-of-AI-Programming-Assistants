(define (sum-numbers root)
  (define (helper node current-sum)
    (cond
      [(null? node) 0]
      [(and (null? (-> node left)) (null? (-> node right))) (+ (* current-sum 10) (-> node val))]
      [else (+ (helper (-> node left) (+ (* current-sum 10) (-> node val)))
               (helper (-> node right) (+ (* current-sum 10) (-> node val))))]))
  (helper root 0))