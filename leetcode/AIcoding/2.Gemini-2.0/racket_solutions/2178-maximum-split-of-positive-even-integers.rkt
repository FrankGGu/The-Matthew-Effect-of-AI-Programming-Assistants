(define (maximum-split positive-integer)
  (cond
    [(<= positive-integer 0) '()]
    [(odd? positive-integer) '()]
    [else
     (let loop ([n positive-integer] [k 2] [acc '()])
       (cond
         [(< n (* 2 k)) (append acc (list n))]
         [else (loop (- n k) (+ k 2) (append acc (list k))))])]))