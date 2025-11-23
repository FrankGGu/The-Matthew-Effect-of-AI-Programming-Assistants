(define (num-steps s)
  (let loop ([s (string->list s)]
             [steps 0])
    (cond
      [(and (null? (cdr s)) (char=? (car s) #\1)) steps]
      [(char=? (last s) #\0) (loop (drop-right s 1) (add1 steps))]
      [else
       (let ([carry 1]
             [res '()])
         (for ([c (in-list (reverse s))])
           (let ([sum (+ (if (char=? c #\1) 1 0) carry)])
             (set! res (cons (if (even? sum) #\0 #\1) res))
             (set! carry (quotient sum 2))))
         (when (= carry 1)
           (set! res (cons #\1 res)))
         (loop res (add1 steps)))])))