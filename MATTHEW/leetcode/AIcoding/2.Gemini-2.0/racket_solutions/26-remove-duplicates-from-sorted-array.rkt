(define (remove-duplicates nums)
  (let loop ([i 1] [k 1] [len (length nums)])
    (cond
      [(>= i len) k]
      [(equal? (list-ref nums (- i 1)) (list-ref nums i))
       (loop (+ i 1) k len)]
      [else
       (begin
         (vector-set! nums k (list-ref nums i))
         (loop (+ i 1) (+ k 1) len))])))