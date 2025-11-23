(define/contract (distribute-candies candies num_people)
  (-> exact-integer? exact-integer? (listof exact-integer?))
  (let loop ([remaining candies]
             [current 1]
             [index 0]
             [result (make-list num_people 0)])
    (if (<= remaining 0)
        result
        (let ([give (min current remaining)])
          (loop (- remaining give)
                (add1 current)
                (modulo (add1 index) num_people)
                (list-update result index (lambda (x) (+ x give)))))))