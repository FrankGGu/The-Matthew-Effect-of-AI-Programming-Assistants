#lang racket

(define (calculate s)
  (define (helper s i sign stack)
    (cond [(= i (string-length s)) (apply + stack)]
          [(char=? #\space (string-ref s i)) (helper s (+ i 1) sign stack)]
          [(char=? #\+) (helper s (+ i 1) 1 stack)]
          [(char=? #\-) (helper s (+ i 1) -1 stack)]
          [(char=? #\() (let ([num (helper s (+ i 1) 1 '())])
                          (helper s (car num) sign (cons (* sign (cadr num)) stack)))]
          [(char=? #\)) (values i (apply + stack))]
          [else
           (let loop ([i i] [num 0])
             (if (and (< i (string-length s)) (char-numeric? (string-ref s i)))
                 (loop (+ i 1) (+ (* num 10) (- (char->integer (string-ref s i)) 48)))
                 (let ([new-stack (cons (* sign num) stack)])
                   (if (and (< i (string-length s)) (char=? #\() (string-ref s i))
                       (let-values ([(i num) (helper s (+ i 1) 1 '())])
                         (helper s i sign (cons (* sign num) new-stack)))
                       (helper s i sign new-stack)))))]))
  (let-values ([(i num) (helper s 0 1 '())]) num))