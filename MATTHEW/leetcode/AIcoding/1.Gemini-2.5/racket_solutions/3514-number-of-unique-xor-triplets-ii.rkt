(define (number-of-unique-xor-triplets-ii nums)
  (let* ([unique-nums-list (sort (remove-duplicates nums) <)]
         [n (length unique-nums-list)]
         [unique-nums-set (list->hash (map (lambda (x) (cons x #t)) unique-nums-list))])
    (define (get-elem idx) (list-ref unique-nums-list idx))
    (let loop-i ((i 0) (count 0))
      (if (>= i (- n 2))
          count
          (let* ([a (get-elem i)])
            (let loop-j ((j (+ i 1)) (current-count count))
              (if (>= j (- n 1))
                  (loop-i (+ i 1) current-count)
                  (let* ([b (get-elem j)]
                         [c-target (bitwise-xor a b)])
                    (if (and (hash-has-key? unique-nums-set c-target)
                             (> c-target b))
                        (loop-j (+ j 1) (+ current-count 1))
                        (loop-j (+ j 1) current-count)))))))))