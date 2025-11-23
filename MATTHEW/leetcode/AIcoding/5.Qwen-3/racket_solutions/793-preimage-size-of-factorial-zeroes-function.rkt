(define (preimage-size-of-factorial-zeroes-function d)
  (define (count-zeros n)
    (let loop ((n n) (count 0))
      (if (= n 0)
          count
          (loop (quotient n 5) (+ count (quotient n 5))))))

  (define (find-smallest x)
    (let loop ((low 0) (high (* 5 x)))
      (if (> low high)
          high
          (let ((mid (quotient (+ low high) 2)))
            (if (< (count-zeros mid) x)
                (loop (+ mid 1) high)
                (loop low (- mid 1)))))))

  (let ((left (find-smallest d)))
    (- (count-zeros (add1 left)) (count-zeros left)))
  )