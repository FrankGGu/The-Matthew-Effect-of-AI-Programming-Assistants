(define (countKReducibleNumbers n k)
  (define (is-k-reducible? x)
    (let loop ((y x))
      (cond ((zero? y) #t)
            ((< y k) #f)
            (else (loop (floor (/ y 10)))))))
  (define (count-helper i count)
    (if (>= i n)
        count
        (count-helper (+ i 1) (if (is-k-reducible? i) (+ count 1) count))))
  (count-helper 0 0))

(countKReducibleNumbers n k)