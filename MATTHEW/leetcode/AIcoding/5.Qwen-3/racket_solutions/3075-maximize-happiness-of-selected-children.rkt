(define/contract (max-happiness children)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([children (sort children >)] [k 0] [total 0])
    (if (or (null? children) (= k 3))
        total
        (loop (cdr children) (+ k 1) (+ total (max 0 (car children)))))))