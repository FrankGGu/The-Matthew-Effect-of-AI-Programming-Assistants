(define (shift-grid grid k)
  (define m (length grid))
  (define n (length (car grid)))
  (define total-elements (* m n))
  (define shifted-list
    (let loop ([i 0] [acc '()])
      (if (= i total-elements)
          acc
          (loop (+ i 1) (append acc (list (list (list-ref (list-ref grid (quotient i n)) (remainder i n)))))))))

  (define shifted-grid
    (let loop ([i 0] [acc '()])
      (if (= i m)
          acc
          (loop (+ i 1) (append acc (list (list-copy (list-ref (list-tail shifted-list (modulo (- total-elements (* i n) k) total-elements)) n))))))))
  shifted-grid)