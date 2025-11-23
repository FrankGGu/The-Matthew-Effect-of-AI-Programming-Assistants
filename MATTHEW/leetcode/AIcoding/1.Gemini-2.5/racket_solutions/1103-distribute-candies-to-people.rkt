(define (distribute-candies candies num_people)
  (let ([result (make-vector num_people 0)])
    (let loop ([candies-left candies]
               [current-candy-amount 1]
               [person-idx 0])
      (when (> candies-left 0)
        (let* ([give-amount (min current-candy-amount candies-left)])
          (vector-set! result person-idx (+ (vector-ref result person-idx) give-amount))
          (loop (- candies-left give-amount)
                (+ current-candy-amount 1)
                (remainder (+ person-idx 1) num_people)))))
    (vector->list result)))