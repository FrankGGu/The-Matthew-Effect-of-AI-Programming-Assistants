(define/contract (max-turbulence-size arr)
  (-> (listof exact-integer?) exact-integer?)
  (define n (length arr))
  (if (= n 1) 1
      (let loop ([i 1] [prev-comp (compare (list-ref arr 0) (list-ref arr 1))] [len (if (= (list-ref arr 0) (list-ref arr 1)) 1 2)] [max-len 2])
        (if (>= i (- n 1))
            (max max-len len)
            (let* ([curr-comp (compare (list-ref arr i) (list-ref arr (+ i 1)))]
              (cond
                [(= curr-comp 0) (loop (+ i 1) 0 1 (max max-len len))]
                [(not (= prev-comp 0)) (if (not (= curr-comp (- prev-comp)))
                                           (loop (+ i 1) curr-comp 2 (max max-len len))
                                           (loop (+ i 1) curr-comp (+ len 1) (max max-len len)))]
                [else (loop (+ i 1) curr-comp 2 (max max-len len))]))))))

(define (compare a b)
  (cond
    [(> a b) 1]
    [(< a b) -1]
    [else 0]))