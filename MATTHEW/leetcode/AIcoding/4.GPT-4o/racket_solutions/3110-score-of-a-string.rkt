(define (scoreOfParentheses s)
  (define (helper s index)
    (cond
      [(= index (string-length s)) 0]
      [(char=? (string-ref s index) #\() 
       (let-values ([(inner-score next-index) 
                     (helper s (+ index 1))])
         (if (= (string-ref s next-index) #\))
             (+ 1 inner-score)
             (+ (* 2 inner-score) (helper s next-index))))
      [else (values 0 (+ index 1))]))
  (car (helper s 0)))

(scoreOfParentheses "(()())")