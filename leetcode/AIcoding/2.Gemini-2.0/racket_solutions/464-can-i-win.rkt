(define (canIWin maxChoosableInteger desiredTotal)
  (define (solve available target memo)
    (cond
      [(<= target 0) #t]
      [(hash-has-key? memo available) (hash-ref memo available)]
      [else
       (let loop ([i 1] [result #t])
         (if (> i maxChoosableInteger)
             (begin
               (hash-set! memo available #f)
               #f)
             (if (bit-set? available i)
                 (loop (+ i 1) result)
                 (let ([next-available (bitwise-ior available (arithmetic-shift 1 (- i 1)))])
                   (if (not (solve next-available (- target i) memo))
                       (begin
                         (hash-set! memo available #t)
                         #t)
                       (loop (+ i 1) result))))))]))

  (if (>= maxChoosableInteger desiredTotal)
      #t
      (if (> (/ (* maxChoosableInteger (+ maxChoosableInteger 1)) 2) desiredTotal)
          (solve 0 desiredTotal (make-hash))
          #f)))