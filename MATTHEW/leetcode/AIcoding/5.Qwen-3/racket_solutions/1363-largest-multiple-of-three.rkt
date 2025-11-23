#lang racket

(define (largest-multiple-of-three p)
  (define (sort-desc lst)
    (sort lst >))

  (define (sum lst)
    (apply + lst))

  (define (remove-one lst val)
    (cond [(null? lst) '()]
          [(= (car lst) val) (cdr lst)]
          [else (cons (car lst) (remove-one (cdr lst) val))]))

  (define nums (sort-desc p))
  (define total (sum nums))

  (define (check-remainder r)
    (let loop ([lst nums] [count 0])
      (cond [(null? lst) #f]
            [(= (modulo (sum lst) 3) r) (cons (sum lst) lst)]
            [else (loop (cdr lst) (+ count 1))])))

  (let ([rem (modulo total 3)])
    (cond [(= rem 0) (string-join (map number->string nums) "")]
          [(= rem 1)
           (let ([res (check-remainder 1)])
             (if res
                 (string-join (map number->string (cdr res)) "")
                 (let ([res2 (check-remainder 2)])
                   (if res2
                       (string-join (map number->string (cdr res2)) "")
                       ""))))]
          [(= rem 2)
           (let ([res (check-remainder 2)])
             (if res
                 (string-join (map number->string (cdr res)) "")
                 (let ([res2 (check-remainder 1)])
                   (if res2
                       (string-join (map number->string (cdr res2)) "")
                       ""))))]))

  (if (and (not (null? nums)) (zero? (sum nums)))
      "0"
      ""))