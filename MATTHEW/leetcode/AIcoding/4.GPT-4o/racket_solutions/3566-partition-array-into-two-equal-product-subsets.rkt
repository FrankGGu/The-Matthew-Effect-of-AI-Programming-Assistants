(define (can-partition nums)
  (define product (apply * nums))
  (define n (length nums))
  (define half-product (sqrt product))

  (define (dfs i p1 p2)
    (cond
      (= i n) (and (= p1 p2) (not (= p1 1)))
      (< p1 1) #f
      (< p2 1) #f
      (else (or (dfs (+ i 1) (* p1 (list-ref nums i)) p2)
                (dfs (+ i 1) p1 (* p2 (list-ref nums i))))))

  (dfs 0 1 1))

(define (canPartition nums)
  (can-partition nums))