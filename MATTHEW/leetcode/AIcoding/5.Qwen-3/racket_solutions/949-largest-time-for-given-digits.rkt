#lang racket

(define (largest-time-from-digits digits)
  (define (is-valid-time h m)
    (and (<= 0 h 23) (<= 0 m 59)))

  (define (to-int lst)
    (if (null? lst)
        0
        (+ (* (car lst) 10) (cadr lst))))

  (define (generate-permutations lst)
    (cond [(null? lst) '()]
          [(null? (cdr lst)) (list lst)]
          [else
           (append
            (map (lambda (x) (cons (car lst) x))
                 (generate-permutations (cdr lst)))
            (generate-permutations (cons (cadr lst) (cons (car lst) (cddr lst)))))]))

  (define (max-time)
    (let loop ([perms (generate-permutations digits)]
               [max-time -1])
      (if (null? perms)
          (if (= max-time -1) "00:00" (format "~a:~a" (quotient max-time 100) (modulo max-time 100)))
          (let* ([p (car perms)]
                 [h (to-int (take p 2))]
                 [m (to-int (drop p 2))]
                 [time (+ (* h 100) m)])
            (if (is-valid-time h m)
                (loop (cdr perms) (max max-time time))
                (loop (cdr perms) max-time))))))

  (max-time))