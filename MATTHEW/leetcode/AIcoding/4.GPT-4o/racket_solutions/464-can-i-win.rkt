(define (can-i-win maxChoosableInteger desiredTotal)
  (define (helper state total)
    (cond
      [(>= total desiredTotal) #f]
      [(zero? (bitwise-and state state)) #t]
      [else
       (for/or ([i (in-range 1 (+ maxChoosableInteger 1))])
         (when (zero? (bitwise-and state (ash 1 (sub1 i))))
           (helper (bitwise-xor state (ash 1 (sub1 i))) (+ total i))))]))
  (if (>= desiredTotal 0)
      (helper (ash 1 maxChoosableInteger) 0)
      #t))