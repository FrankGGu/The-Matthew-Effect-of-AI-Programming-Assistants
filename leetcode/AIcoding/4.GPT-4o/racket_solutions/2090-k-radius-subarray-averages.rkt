(define (getAverages nums k)
  (define n (length nums))
  (define result (make-vector n -1))
  (define (compute-sum start end)
    (if (>= end n) 
        0 
        (+ (vector-ref nums end) (compute-sum start (+ end 1)))))
  (define total-sum (compute-sum 0 (sub1 (* 2 k))))
  (for ([i (in-range k (sub1 (- n k)))])
    (vector-set! result i (quotient total-sum (* 2 k 1))))
  (for ([i (in-range k (sub1 (- n k)))])
    (set! total-sum 
          (+ total-sum (- (vector-ref nums (+ i k)) (vector-ref nums (- i k))))))
  (vector->list result))

(getAverages '(7 4 3 9 1 8) 3)