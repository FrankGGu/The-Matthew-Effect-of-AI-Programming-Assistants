(define (count-prime-set-bits L R)
  (define (count-set-bits n)
    (let loop ((num n) (count 0))
      (if (= num 0)
          count
          (loop (bitwise-and num (- num 1)) (+ count 1)))))

  (define (is-prime? n)
    (member n '(2 3 5 7 11 13 17 19)))

  (let loop ((i L) (total-count 0))
    (if (> i R)
        total-count
        (let ((set-bits (count-set-bits i)))
          (if (is-prime? set-bits)
              (loop (+ i 1) (+ total-count 1))
              (loop (+ i 1) total-count))))))