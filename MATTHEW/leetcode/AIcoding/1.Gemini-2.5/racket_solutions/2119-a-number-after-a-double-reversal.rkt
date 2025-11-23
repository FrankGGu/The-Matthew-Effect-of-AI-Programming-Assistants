(define (is-same-after-reversals num)
  (or (= num 0)
      (not (= (remainder num 10) 0))))