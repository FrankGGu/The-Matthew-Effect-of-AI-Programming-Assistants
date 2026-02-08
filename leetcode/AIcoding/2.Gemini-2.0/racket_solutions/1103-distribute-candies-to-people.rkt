(define (distribute-candies candies num-people)
  (let loop ([candies candies]
             [result (make-vector num-people 0)]
             [give 1]
             [idx 0])
    (cond
      [(zero? candies) result]
      [(>= candies give)
       (vector-set! result idx (+ (vector-ref result idx) give))
       (loop (- candies give) result (+ 1 give) (modulo (+ 1 idx) num-people))]
      [else
       (vector-set! result idx (+ (vector-ref result idx) candies))
       result])))