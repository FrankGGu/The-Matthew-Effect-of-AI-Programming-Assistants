(define (has-path-sum root targetSum)
  (cond
    [(null? root) #f]
    [(and (null? (-> root 'left)) (null? (-> root 'right))) (= targetSum (-> root 'val))]
    [else (or (has-path-sum (-> root 'left) (- targetSum (-> root 'val)))
              (has-path-sum (-> root 'right) (- targetSum (-> root 'val))))]))