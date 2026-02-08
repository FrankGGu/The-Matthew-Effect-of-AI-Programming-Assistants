(define (pass-the-pillow n time)
  (let loop ([current 0] [time time] [direction 1])
    (if (zero? time)
        current
        (loop (if (= current 0) 1 (if (= current (sub1 n)) (sub1 n) (if (= direction 1) (add1 current) (sub1 current))))
              (sub1 time)
              (if (= current 0) 1 (if (= current (sub1 n)) (sub1 direction) direction))))))

(define (passThePillow n time)
  (pass-the-pillow n time))