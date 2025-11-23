(define/contract (find-duplicates nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let loop ([nums nums] [seen (hash)] [result '()])
    (cond
      [(null? nums) (reverse result)]
      [(hash-has-key? seen (car nums))
       (loop (cdr nums) seen (cons (car nums) result))]
      [else
       (loop (cdr nums) (hash-set seen (car nums) #t) result)])))