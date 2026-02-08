(define (maximumValue A)
  (define n (length A))
  (define max1 (apply max A))
  (define max2 (apply max (filter (lambda (x) (not (= x max1))) A)))
  (define max3 (apply max (filter (lambda (x) (not (or (= x max1) (= x max2)))) A)))
  (define max4 (apply max (filter (lambda (x) (not (or (= x max1) (= x max2) (= x max3)))) A)))
  (max (+ max1 max2 max3) (+ max1 max2 max4) (+ max1 max3 max4) (+ max2 max3 max4)))

(define (maximumValueOfTriplet A)
  (if (< (length A) 3)
      0
      (maximumValue A)))