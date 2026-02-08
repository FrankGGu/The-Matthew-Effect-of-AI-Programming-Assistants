(define/contract (minimize-sum nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([sorted (sort nums <)]
         [n (length sorted)]
         [option1 (- (list-ref sorted (- n 1)) (list-ref sorted 2))]
         [option2 (- (list-ref sorted (- n 2)) (list-ref sorted 1))]
         [option3 (- (list-ref sorted (- n 3)) (list-ref sorted 0))])
    (min option1 option2 option3)))