(define/contract (is-ideal-permutation nums)
  (-> (listof exact-integer?) boolean?)
  (let loop ([i 0] [max-so-far -inf.0])
    (cond
      [(>= i (- (length nums) 2)) #t]
      [else
       (let ([current (list-ref nums i)])
         (if (> current max-so-far)
             (loop (+ i 1) current)
             (if (> current (list-ref nums (+ i 2)))
                 #f
                 (loop (+ i 1) max-so-far))))])))