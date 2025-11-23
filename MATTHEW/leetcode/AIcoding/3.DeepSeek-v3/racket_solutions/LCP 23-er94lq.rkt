(define (isMagical target)
  (let loop ([i 0] [j (sub1 (length target))] [turn #t] [current 1])
    (cond
      [(> current (length target)) #t]
      [(turn
       (if (equal? (list-ref target i) current)
           (loop (add1 i) j (not turn) (add1 current))
           #f)]
      [else
       (if (equal? (list-ref target j) current)
           (loop i (sub1 j) (not turn) (add1 current))
           #f)])))