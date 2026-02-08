(define/contract (min-moves-to-seat seats students)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let ([sorted-seats (sort seats <)]
        [sorted-students (sort students <)])
    (for/sum ([s sorted-seats]
               [t sorted-students])
      (abs (- s t)))))