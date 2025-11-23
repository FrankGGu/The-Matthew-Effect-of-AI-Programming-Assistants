(define (max-money n k)
  (let loop ([l 1] [r n] [sum 0])
    (cond
      [(> l r) sum]
      [(< (- r l) k) (loop (+ r 1) (- l 1) (+ sum (+ l r)))]
      [else (loop (+ l k 1) (- r k 1) (+ sum (+ (quotient (+ l (+ l k)) 2) (* k 2) ))])))