(define/contract (median-sliding-window nums k)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (define (median lst)
    (let* ([sorted (sort lst <)]
           [len (length sorted)]
           [mid (quotient len 2)])
      (if (odd? len)
          (list-ref sorted mid)
          (/ (+ (list-ref sorted mid) (list-ref sorted (- mid 1))) 2))))
  (let loop ([i 0] [result '()])
    (if (> (+ i k) (length nums))
        (reverse result)
        (loop (+ i 1) (cons (median (take (drop nums i) k)) result)))))