(define (temperature-trend A B)
  (define (compare a b)
    (cond [(> a b) 1]
          [(< a b) -1]
          [else 0]))
  (define (helper i count)
    (if (= i (- (length A) 1))
        count
        (let ([c (compare (list-ref A i) (list-ref B i))]
              [d (compare (list-ref A (+ i 1)) (list-ref B (+ i 1)))])
          (if (= c d)
              (helper (+ i 1) (+ count 1))
              (helper (+ i 1) count)))))
  (helper 0 0))