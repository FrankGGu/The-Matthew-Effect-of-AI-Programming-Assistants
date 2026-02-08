(define (max-factor-score nums)
  (define (factor-score num)
    (define (count-factors n)
      (let loop ((i 1) (count 0))
        (cond ((> i n) count)
              ((= (modulo n i) 0) (loop (+ i 1) (+ count 1)))
              (else (loop (+ i 1) count)))))
    (count-factors num))

  (define (max-score lst)
    (apply max (map factor-score lst)))

  (max-score nums))