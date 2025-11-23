#lang racket

(define (max-points points)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))

  (define (slope p1 p2)
    (let* ([dx (- (car p2) (car p1))]
           [dy (- (cadr p2) (cadr p1))]
           [g (gcd dx dy)])
      (if (= dx 0)
          (cons 0 1)
          (if (= dy 0)
              (cons 1 0)
              (cons (/ dx g) (/ dy g))))))

  (define (count-points p rest)
    (let loop ([rest rest] [m (hash)] [max 0])
      (if (null? rest)
          max
          (let* ([s (slope p (car rest))]
                 [cnt (+ 1 (hash-ref m s 0))])
            (loop (cdr rest) (hash-set m s cnt) (max max cnt))))))

  (if (= (length points) 1)
      1
      (let loop ([points points] [max 0])
        (if (null? points)
            max
            (let ([current (car points)]
                  [rest (cdr points)])
              (loop (cdr points) (max max (count-points current rest))))))))