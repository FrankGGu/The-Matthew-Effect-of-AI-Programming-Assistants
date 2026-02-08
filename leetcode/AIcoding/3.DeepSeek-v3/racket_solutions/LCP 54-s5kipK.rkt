(define/contract (capture-forts forts)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [j 0] [max-capture 0])
    (cond
      [(>= j (length forts)) max-capture]
      [(= (list-ref forts j) 1)
       (if (and (< i j) (= (list-ref forts i) -1))
           (loop (add1 j) (add1 j) (max max-capture (- j i 1)))
           (loop (add1 j) (add1 j) max-capture))]
      [(= (list-ref forts j) -1)
       (if (and (< i j) (= (list-ref forts i) 1))
           (loop (add1 j) (add1 j) (max max-capture (- j i 1)))
           (loop (add1 j) (add1 j) max-capture))]
      [else (loop i (add1 j) max-capture)])))