(define (distinct-colors balls)
  (define total-balls (apply + balls))
  (define (fact n)
    (cond [(<= n 1) 1]
          [else (apply * (range 2 (+ n 1)))]))
  (define (comb n k)
    (/ (fact n) (* (fact k) (fact (- n k)))))

  (define (helper balls total-balls)
    (cond
      [(= (length balls) 0) 1]
      [else
       (let ([first-ball (car balls)]
             [rest-balls (cdr balls)])
         (remainder (* (comb total-balls first-ball) (helper rest-balls (- total-balls first-ball))) 1000000007))]))

  (helper balls total-balls))