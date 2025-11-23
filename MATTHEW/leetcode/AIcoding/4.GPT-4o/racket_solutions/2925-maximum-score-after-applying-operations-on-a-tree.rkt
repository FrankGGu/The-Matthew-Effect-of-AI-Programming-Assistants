(define (maxScore edges n)
  (define (dfs node parent)
    (let loop ((children (cdr (assoc node edges))) (total 0))
      (if (null? children)
          total
          (loop (cdr children) (+ total (max (dfs (car children) node) 0)))))))

  (let loop ((i 0) (result 0))
    (if (= i n)
        result
        (loop (+ i 1) (max result (dfs i -1)))))))

(define (maximumScore edges n)
  (maxScore edges n))