(define (sum-zero n)
  (if (= n 1)
      '(0)
      (let loop ((i 1) (result '()))
        (if (> i n)
            result
            (loop (+ i 1) (cons (- i) result))))))