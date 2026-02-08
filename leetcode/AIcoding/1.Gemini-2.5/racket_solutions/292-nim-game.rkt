(define/public (can-win-nim n)
  (not (= (remainder n 4) 0)))