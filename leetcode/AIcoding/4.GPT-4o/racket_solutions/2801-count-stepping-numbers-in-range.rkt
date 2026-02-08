(define (countSteppingNumbers low high)
  (define (is-stepping? n)
    (let loop ((prev -1) (n n))
      (if (zero? n)
          #t
          (let ((digit (modulo n 10)))
            (if (or (and (not (= prev -1)) (not (= (abs (- prev digit)) 1)))
                    (> digit 9))
                #f
                (loop digit (quotient n 10)))))))

  (define (count-in-range low high)
    (let loop ((num low) (count 0))
      (if (> num high)
          count
          (loop (+ num 1) (if (is-stepping? num) (+ count 1) count)))))

  (count-in-range low high))

(countSteppingNumbers 0 21)