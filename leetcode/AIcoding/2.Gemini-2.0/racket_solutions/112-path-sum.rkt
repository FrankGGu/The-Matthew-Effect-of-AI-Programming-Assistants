(define (has-path-sum root target-sum)
  (cond
    [(null? root) #f]
    [else
     (let ([remaining (- target-sum (struct-ref root val))])
       (cond
         [(and (null? (struct-ref root left)) (null? (struct-ref root right)))
          (= remaining 0)]
         [else
          (or (and (not (null? (struct-ref root left))) (has-path-sum (struct-ref root left) remaining))
              (and (not (null? (struct-ref root right))) (has-path-sum (struct-ref root right) remaining)))]))])))