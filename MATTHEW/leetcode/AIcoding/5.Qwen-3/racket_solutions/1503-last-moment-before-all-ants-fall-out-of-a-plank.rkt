(define (last-moment-before-all-ants-fall-out-of-a-plank n left right)
  (define (max-time lst)
    (if (null? lst)
        0
        (apply max (map (lambda (x) x) lst))))
  (define (min-time lst)
    (if (null? lst)
        0
        (apply min (map (lambda (x) x) lst))))
  (let ([left-time (max-time left)]
        [right-time (min-time right)])
    (max left-time (- n right-time))))