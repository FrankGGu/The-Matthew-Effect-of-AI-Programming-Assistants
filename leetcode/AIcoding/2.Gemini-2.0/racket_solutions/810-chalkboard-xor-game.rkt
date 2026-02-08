(define (xor-game nums)
  (define n (length nums))
  (define xor-sum (foldl xor 0 nums))
  (if (= n 1)
      #t
      (if (= (modulo n 2) 0)
          #t
          (= xor-sum 0))))