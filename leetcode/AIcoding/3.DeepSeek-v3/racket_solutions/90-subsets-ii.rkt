(define/contract (subsets-with-dup nums)
  (-> (listof exact-integer?) (listof (listof exact-integer?)))
  (let loop ([nums (sort nums <)] [res '(()]) [i 0])
    (if (>= i (length nums))
        res
        (let* ([count 1]
               [count (let count-loop ([j (add1 i)])
                        (if (and (< j (length nums)) (equal? (list-ref nums j) (list-ref nums i)))
                            (count-loop (add1 j) (add1 count))
                            count))])
          (loop (drop nums count)
                (append res (map (lambda (lst) (append lst (make-list count (list-ref nums i)))) (take res (expt 2 (length (filter (lambda (x) (< x (list-ref nums i))) res))))))
                (+ i count))))))