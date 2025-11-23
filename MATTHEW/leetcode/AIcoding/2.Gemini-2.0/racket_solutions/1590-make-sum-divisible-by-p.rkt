(define (min-sub-array-len nums p)
  (define n (length nums))
  (define (sum-mod nums p)
    (foldl (lambda (x acc) (modulo (+ acc x) p)) 0 nums))
  (define target (sum-mod nums p))
  (if (= target 0)
      0
      (let loop ([i 0] [prefix-sum 0] [min-len (+ n 1)] [prefix-map (hash (cons 0 -1))])
        (if (= i n)
            (if (= min-len (+ n 1)) -1 min-len)
            (let* ([curr-sum (modulo (+ prefix-sum (list-ref nums i)) p)]
                   [needed (modulo (- curr-sum target) p)])
              (let ([new-min-len
                     (if (hash-has-key? prefix-map needed)
                         (min min-len (- i (hash-ref prefix-map needed)))
                         min-len)])
                (if (hash-has-key? prefix-map curr-sum)
                    (loop (+ i 1) curr-sum new-min-len prefix-map)
                    (loop (+ i 1) curr-sum new-min-len (hash-set prefix-map curr-sum i)))))))))