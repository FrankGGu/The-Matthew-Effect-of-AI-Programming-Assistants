#lang racket

(define (is-prime n)
  (cond [(<= n 1) #f]
        [(= n 2) #t]
        [(even? n) #f]
        [else
         (define sqrt-n (sqrt n))
         (for/first ([i (in-range 3 (add1 (floor sqrt-n)) 2)]
                     #:when (= (modulo n i) 0))
           #f)
         #t]))

(define (closest-prime-numbers-in-range low high)
  (define (find-next-prime start)
    (let loop ([n start])
      (if (is-prime n)
          n
          (loop (add1 n)))))

  (define (find-prev-prime start)
    (let loop ([n start])
      (if (and (> n 1) (is-prime n))
          n
          (loop (sub1 n)))))

  (define first (find-next-prime low))
  (if (or (> first high) (not (is-prime first)))
      #f
      (let ([second (find-next-prime (add1 first))])
        (if (> second high)
            #f
            (list first second)))))

(define (solve)
  (let ([low (read)])
    (let ([high (read)])
      (let ([result (closest-prime-numbers-in-range low high)])
        (if result
            (printf "~a ~a\n" (car result) (cadr result))
            (printf "-1\n"))))))

(solve)