(define (minSwaps grid)
  (define n (length grid))
  (define (trailing-zeros row)
    (let loop ([i (- n 1)] [count 0])
      (cond
        [(< i 0) count]
        [(= (list-ref row i) 0) (loop (- i 1) (+ count 1))]
        [else count])))
  (define zeros (map trailing-zeros grid))
  (define (find-index k start)
    (let loop ([i start])
      (cond
        [(>= i n) -1]
        [(>= (list-ref zeros i) k) i]
        [else (loop (+ i 1))])))
  (define (swap! arr i j)
    (let ([temp (list-ref arr i)])
      (set! arr (list-set arr i (list-ref arr j)))
      (set! arr (list-set arr j temp))))
  (let loop ([i 0] [swaps 0])
    (cond
      [(>= i n) swaps]
      [else
       (let ([needed (- n i 1)])
         (let ([index (find-index needed i)])
           (cond
             [(= index -1) -1]
             [else
              (let loop2 ([j index])
                (cond
                  [(= j i) (loop (+ i 1) swaps)]
                  [else
                   (swap! zeros j (- j 1))
                   (loop2 (- j 1))]))]))]))))