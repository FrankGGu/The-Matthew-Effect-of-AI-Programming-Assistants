(define (max-satisfied customers grumpy X)
  (let ([n (length customers)])
    (let loop ([i 0] [curr-sum 0] [max-sum 0])
      (cond
        [(= i n) max-sum]
        [else
         (let ([new-curr-sum (+ curr-sum (if (= (list-ref grumpy i) 1) (list-ref customers i) 0))])
           (if (> i (- X 1))
               (loop (+ i 1) (- new-curr-sum (if (= (list-ref grumpy (- i X)) 1) (list-ref customers (- i X)) 0)) (max max-sum new-curr-sum))
               (loop (+ i 1) new-curr-sum (max max-sum new-curr-sum)))))]))
    (let ([base-satisfied (foldl + 0 (map (lambda (c g) (if (= g 0) c 0)) customers grumpy))])
      (+ base-satisfied (loop 0 0 0)))))