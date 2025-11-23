(define/contract (min-cost nums cost)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (define (weighted-median nums cost)
    (let* ([pairs (sort (map cons nums cost) (lambda (x y) (< (car x) (car y))))]
           [total (foldl + 0 (map cdr pairs))]
           [half (quotient total 2)]
           [sum 0]
           [median 0])
      (for ([pair pairs] #:break (> sum half))
        (set! sum (+ sum (cdr pair)))
        (set! median (car pair)))
      median))
  (define target (weighted-median nums cost))
  (foldl + 0 (map (lambda (n c) (* (abs (- n target)) c)) nums cost)))