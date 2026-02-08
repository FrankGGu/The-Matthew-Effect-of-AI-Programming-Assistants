(define (can-distribute nums quantity)
  (define counts (make-hash))
  (for-each (lambda (n) (hash-update! counts n add1 0)) nums)
  (define freq (sort (hash-values counts) >))
  (define sorted-quantity (sort quantity >))

  (define (solve freq sorted-quantity)
    (cond
      [(null? sorted-quantity) #t]
      [(null? freq) #f]
      [else
       (let ([q (car sorted-quantity)]
             [rest-quantity (cdr sorted-quantity)])
         (let loop ([i 0])
           (cond
             [(>= i (length freq)) #f]
             [else
              (let ([f (list-ref freq i)])
                (if (>= f q)
                    (let ([new-freq (list-update freq i (lambda (x) (- x q)))])
                      (if (solve (sort (filter (> 0) new-freq) >) rest-quantity)
                          #t
                          (loop (+ i 1))))
                    (loop (+ i 1))))))]))]))

  (solve freq sorted-quantity))