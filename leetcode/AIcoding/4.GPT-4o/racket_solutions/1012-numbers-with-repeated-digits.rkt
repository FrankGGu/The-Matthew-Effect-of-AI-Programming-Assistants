(define (numDupDigitsAtMostN n)
  (define (factorial x)
    (if (= x 0) 1 (* x (factorial (- x 1)))))

  (define digits (map (lambda (x) (- (modulo n 10) (modulo x 10))) (range 1 11)))
  (define len (length (number->string n)))

  (define total 0)
  (for ((i (in-range 1 len)))
    (set! total (+ total (* (factorial 9) (factorial (- 10 i)) (expt 9 (- i 1))))))

  (define used (make-vector 10 #f))
  (define (count-repeated d pos)
    (if (= pos len)
        1
        (let loop ((count 0) (i 0))
          (if (>= i d)
              count
              (let* ((digit (list-ref digits i))
                     (new-used (vector-copy used)))
                (if (vector-ref new-used digit)
                    (loop count (+ i 1))
                    (begin
                      (vector-set! new-used digit #t)
                      (loop (+ count (count-repeated d (+ pos 1))) (+ i 1)))))))))

  (set! total (+ total (- n (count-repeated (modulo n 10) 0))))

  total)

(numDupDigitsAtMostN n)