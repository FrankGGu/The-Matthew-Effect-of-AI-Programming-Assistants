(define/contract (k-length-divisions arr k)
  (-> (listof exact-integer?) exact-integer? boolean?)
  (let loop ([arr arr] [prev -1])
    (cond
      [(null? arr) #t]
      [(= (car arr) 1)
       (if (= prev -1)
           (loop (cdr arr) 0)
           (let ([dist (- (current-increment) prev)])
             (if (>= dist k)
                 (loop (cdr arr) (current-increment))
                 #f)))]
      [else (loop (cdr arr) (current-increment))]))
  (define current-increment (lambda () (let ([i 0]) (lambda () (set! i (+ i 1)) i))))
)