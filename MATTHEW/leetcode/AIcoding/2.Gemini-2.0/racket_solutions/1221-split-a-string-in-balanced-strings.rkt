(define (balanced-string-split s)
  (define (helper str count balance)
    (cond
      [(empty? str) count]
      [(equal? (first str) #\L)
       (let ([new-balance (+ balance 1)])
         (if (zero? new-balance)
             (helper (rest str) (+ count 1) new-balance)
             (helper (rest str) count new-balance)))]
      [else
       (let ([new-balance (- balance 1)])
         (if (zero? new-balance)
             (helper (rest str) (+ count 1) new-balance)
             (helper (rest str) count new-balance)))])
    )
  (helper (string->list s) 0 0))