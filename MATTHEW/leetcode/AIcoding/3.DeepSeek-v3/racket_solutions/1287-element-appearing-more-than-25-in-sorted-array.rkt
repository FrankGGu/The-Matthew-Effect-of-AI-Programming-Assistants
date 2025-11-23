(define/contract (find-special-integer arr)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [n (length arr)] [count 1])
    (cond
      [(>= i (- n 1)) (list-ref arr (- n 1))]
      [(= (list-ref arr i) (list-ref arr (+ i 1)))
       (if (>= (+ count 1) (ceiling (/ n 4)))
           (list-ref arr i)
           (loop (+ i 1) n (+ count 1)))]
      [else (loop (+ i 1) n 1)])))