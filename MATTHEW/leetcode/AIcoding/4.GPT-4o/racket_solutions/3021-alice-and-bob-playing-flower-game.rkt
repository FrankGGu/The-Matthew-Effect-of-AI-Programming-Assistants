(define (flowerGame flowers)
  (define (canWin n)
    (if (>= n (length flowers)) #f
        (if (equal? (list-ref flowers n) 0)
            (or (canWin (+ n 1)) 
                (and (>= n 1) (equal? (list-ref flowers (- n 1)) 0) (canWin (+ n 2)))) 
                (and (>= n 2) (equal? (list-ref flowers (- n 2)) 0) (canWin (+ n 3)))) 
            #f)))
  (canWin 0))