#lang racket

(define (parse-boolean-expression expression)
  (define (eval-expr s)
    (cond [(char=? #\t (string-ref s 0)) #t]
          [(char=? #\f (string-ref s 0)) #f]
          [(char=? #\! (string-ref s 0))
           (not (eval-expr (substring s 2 (sub1 (string-length s)))))]
          [(char=? #\& (string-ref s 0))
           (let loop ([i 2] [res #t])
             (if (= i (string-length s))
                 res
                 (let ([j (index-of s #\, i)])
                   (if j
                       (loop (+ j 1) (and res (eval-expr (substring s i j))))
                       (and res (eval-expr (substring s i (string-length s))))))))]
          [(char=? #\| (string-ref s 0))
           (let loop ([i 2] [res #f])
             (if (= i (string-length s))
                 res
                 (let ([j (index-of s #\, i)])
                   (if j
                       (loop (+ j 1) (or res (eval-expr (substring s i j))))
                       (or res (eval-expr (substring s i (string-length s)))))))]))
  (eval-expr expression))