(define (contains-duplicate nums)
  (define (helper seen lst)
    (cond
      [(empty? lst) #f]
      [(hash-has-key? seen (first lst)) #t]
      [else (helper (hash-set seen (first lst) #t) (rest lst))]))
  (helper (make-hash) nums))