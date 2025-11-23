(define (find-x-value nums)
  (let loop ([i 0])
    (if (= i (length nums))
        -1
        (let ([left-sum (apply + (take nums i))]
              [right-sum (apply + (drop nums (add1 i)))])
          (if (= left-sum right-sum)
              i
              (loop (add1 i)))))))