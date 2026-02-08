(define (maximize-minimum-city power stations)
  (define (can-satisfy x)
    (let loop ((i 0) (remaining power))
      (if (or (null? stations) (>= x (car stations)))
          (>= remaining 0)
          (if (< remaining (car stations))
              #f
              (loop (1+ i) (- remaining (- (car stations) x)))))))

  (define power (apply + stations))
  (define max-min 0)

  (define left 0)
  (define right (apply max stations))

  (while (<= left right)
    (define mid (quotient (+ left right) 2))
    (if (can-satisfy mid)
        (begin
          (set! max-min mid)
          (set! left (1+ mid)))
        (set! right (sub1 mid))))

  max-min)

(maximize-minimum-city '(1 2 3) '(10 20 30))