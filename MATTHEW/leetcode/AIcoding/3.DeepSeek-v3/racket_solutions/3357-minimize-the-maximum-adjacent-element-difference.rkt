(define/contract (minimize-max-difference nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([sorted (sort nums <)]
         [n (length sorted)]
         [min-diff (- (list-ref sorted (- n 1)) (list-ref sorted 0))]
         [window-size (- n k)])
    (if (<= window-size 1)
        min-diff
        (let loop ([i 0] [res min-diff])
          (if (>= (+ i window-size) n)
              res
              (loop (+ i 1) (min res (- (list-ref sorted (+ i window-size)) (list-ref sorted i))))))))