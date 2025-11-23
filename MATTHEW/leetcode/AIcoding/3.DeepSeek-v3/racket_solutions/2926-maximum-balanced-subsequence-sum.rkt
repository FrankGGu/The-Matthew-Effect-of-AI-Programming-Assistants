(define/contract (max-balanced-subsequence-sum nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (length nums)]
         [sorted (sort (for/list ([i (in-range n)] (cons i (list-ref nums i))) )
                       (lambda (a b) (if (= (car a) (car b))
                                         (< (cdr a) (cdr b))
                                         (< (car a) (car b)))))]
         [lis (make-vector n -inf.0)]
         [binary-search (lambda (val)
                         (let loop ([low 0] [high (- n 1)] [res -1])
                           (if (> low high)
                               res
                               (let* ([mid (quotient (+ low high) 2)]
                                      [mid-val (vector-ref lis mid)])
                                 (if (<= mid-val val)
                                     (loop (+ mid 1) high mid)
                                     (loop low (- mid 1) res))))))])
    (for ([pair sorted])
      (let* ([idx (car pair)]
             [num (cdr pair)]
             [j (binary-search (- num idx))])
        (vector-set! lis (if (= j -1) 0 (+ j 1)) (max (if (= j -1) 0 (vector-ref lis j)) (+ num (if (= j -1) 0 (vector-ref lis j)))))))
    (let loop ([i 0] [max-sum -inf.0])
      (if (= i n)
          max-sum
          (loop (+ i 1) (max max-sum (vector-ref lis i)))))))