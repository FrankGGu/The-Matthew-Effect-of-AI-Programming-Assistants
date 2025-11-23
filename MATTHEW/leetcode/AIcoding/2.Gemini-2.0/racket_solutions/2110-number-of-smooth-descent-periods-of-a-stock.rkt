(define (get-descent-periods prices)
  (let* ((n (length prices))
         (dp (make-vector n 1)))
    (for/fold (sum 1) ((i (in-range 1 n)))
      (if (= (list-ref prices i) (+ (list-ref prices (- i 1)) -1))
          (begin
            (vector-set! dp i (+ (vector-ref dp (- i 1)) 1))
            (+ sum (vector-ref dp i)))
          (+ sum 1)))))