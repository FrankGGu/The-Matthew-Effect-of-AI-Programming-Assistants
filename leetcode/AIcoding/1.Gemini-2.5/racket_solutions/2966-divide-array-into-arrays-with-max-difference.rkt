(define (divide-array-into-arrays-with-max-difference nums k)
  (let* ([n (length nums)]
         [sorted-nums (sort nums <)])
    (if (not (= (modulo n 3) 0))
        '() ; Should not happen based on problem constraints, but good practice
        (let loop ([idx 0]
                   [result '()])
          (if (>= idx n)
              (reverse result)
              (let* ([a (list-ref sorted-nums idx)]
                     [b (list-ref sorted-nums (+ idx 1))]
                     [c (list-ref sorted-nums (+ idx 2))])
                (if (<= (- c a) k)
                    (loop (+ idx 3) (cons (list a b c) result))
                    '())))))))