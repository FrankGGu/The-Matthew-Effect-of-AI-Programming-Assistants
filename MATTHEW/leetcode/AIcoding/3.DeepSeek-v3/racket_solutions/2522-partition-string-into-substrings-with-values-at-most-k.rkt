(define (minimum-partition s k)
  (let loop ([s s] [current 0] [count 1])
    (if (null? s)
        count
        (let* ([digit (- (char->integer (car s)) 48)]
               [new-current (+ (* current 10) digit)])
          (if (> new-current k)
              (if (and (> digit 0) (<= digit k))
                  (loop (cdr s) digit (+ count 1))
                  -1)
              (loop (cdr s) new-current count))))))