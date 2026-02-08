(define (minimumLines stockPrices)
  (define sorted-prices (sort stockPrices (lambda (a b) (< (vector-ref a 0) (vector-ref b 0)))))
  (define (slope p1 p2)
    (if (= (vector-ref p2 0) (vector-ref p1 0))
        #f
        (/ (- (vector-ref p2 1) (vector-ref p1 1)) (- (vector-ref p2 0) (vector-ref p1 0)))))
  (define n (vector-length sorted-prices))
  (if (<= n 1) 
      0
      (let loop ((i 1) (count 0) (current-slope (slope (vector-ref sorted-prices 0) (vector-ref sorted-prices 1))))
        (if (= i (sub1 n))
            count
            (let* ((new-slope (slope (vector-ref sorted-prices i) (vector-ref sorted-prices (add1 i)))))
              (if (equal? new-slope current-slope)
                  (loop (add1 i) count current-slope)
                  (loop (add1 i) (add1 count) new-slope))))))))