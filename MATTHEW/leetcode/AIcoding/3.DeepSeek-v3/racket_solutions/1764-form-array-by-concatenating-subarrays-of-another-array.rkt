(define/contract (can-choose groups nums)
  (-> (listof (listof exact-integer?)) (listof exact-integer?) boolean?)
  (let loop ([groups groups] [nums nums])
    (cond
      [(empty? groups) #t]
      [(empty? nums) #f]
      [else
       (let ([g (first groups)])
       (if (starts-with? nums g)
           (loop (rest groups) (drop nums (length g)))
           (loop groups (rest nums))))]))

(define (starts-with? lst prefix)
  (cond
    [(empty? prefix) #t]
    [(empty? lst) #f]
    [(equal? (first lst) (first prefix))
     (starts-with? (rest lst) (rest prefix))]
    [else #f]))