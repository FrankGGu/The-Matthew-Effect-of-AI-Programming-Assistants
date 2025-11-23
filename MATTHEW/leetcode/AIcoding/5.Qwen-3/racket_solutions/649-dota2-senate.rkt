#lang racket

(define (predict-who-wins s)
  (define (count-votes s)
    (let loop ([s s] [r 0] [d 0])
      (cond [(null? s) (values r d)]
            [(char=? (car s) #\R) (loop (cdr s) (+ r 1) d)]
            [else (loop (cdr s) r (+ d 1))])))

  (define (simulate s)
    (let loop ([s s] [r 0] [d 0])
      (cond [(and (= r 0) (= d 0)) #f]
            [(= r 0) #\D]
            [(= d 0) #\R]
            [else
             (let* ([r-count (if (char=? (car s) #\R) (+ r 1) r)]
                    [d-count (if (char=? (car s) #\D) (+ d 1) d)]
                    [next-s (cdr s)])
               (loop next-s r-count d-count))])))

  (let-values ([(r d) (count-votes s)])
    (if (> r d) #\R #\D)))

(define (dota2-senate senate)
  (let loop ([s (string->list senate)])
    (let ([winner (predict-who-wins s)])
      (if (eqv? winner #\R)
          "Radiant"
          "Dire"))))