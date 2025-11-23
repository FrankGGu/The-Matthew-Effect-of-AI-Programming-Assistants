(define (minimum-pushes word)
  (let* ((len (string-length word))
         (q (quotient len 8)))
    (+ (* q 4)
       (cond
         [(< len 1) 0]
         [(<= len 8) len]
         [(<= len 16) (- len 8)]
         [(<= len 24) (- len 16)]
         [else (- len 24)]))))