(define (common-factors a b)
  (let* ((limit (min a b)))
    (for/sum ([i (range 1 (+ limit 1))])
      (if (and (= (modulo a i) 0)
               (= (modulo b i) 0))
          1
          0))))