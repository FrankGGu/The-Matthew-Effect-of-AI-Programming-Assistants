(define/contract (check-if-exist arr)
  (-> (listof exact-integer?) boolean?)
  (let loop ([seen (hash)]
             [lst arr])
    (cond
      [(null? lst) #f]
      [(or (hash-has-key? seen (* 2 (car lst)))
           (hash-has-key? seen (quotient (car lst) 2)) (zero? (modulo (car lst) 2))))
       #t]
      [else (loop (hash-set seen (car lst) #t) (cdr lst))])))