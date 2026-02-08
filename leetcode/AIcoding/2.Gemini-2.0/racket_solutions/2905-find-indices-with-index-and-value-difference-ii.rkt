(define (find-indices nums index-difference value-difference)
  (let* ([n (length nums)])
    (for*/first
     ([i (in-range n)]
      [j (in-range n)]
      #:when (and (<= index-difference (abs (- i j)))
                  (<= value-difference (abs (- (list-ref nums i) (list-ref nums j))))))
     (list i j))))