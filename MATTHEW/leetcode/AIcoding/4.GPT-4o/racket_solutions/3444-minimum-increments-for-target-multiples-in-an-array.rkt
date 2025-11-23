(define (min-increments nums target)
  (define (count-increments n)
    (if (= n 0)
        0
        (let ((next-multiple (if (= (modulo n target) 0) n (+ n (- (modulo n target) target)))))
          (+ (- next-multiple n) (count-increments next-multiple)))))
  (apply + (map count-increments nums)))

(min-increments '(3 2 4) 6)