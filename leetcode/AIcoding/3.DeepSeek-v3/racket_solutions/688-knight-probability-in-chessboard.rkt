(define (knight-probability n k row column)
  (let ([dp (make-hash)])
    (define (dfs r c k)
      (cond
        [(or (< r 0) (>= r n) (< c 0) (>= c n)) 0]
        [(= k 0) 1]
        [(hash-has-key? dp (list r c k)) (hash-ref dp (list r c k))]
        [else
         (let ([res 0])
           (for ([dir '((-2 -1) (-1 -2) (1 -2) (2 -1) (2 1) (1 2) (-1 2) (-2 1))])
             (let ([nr (+ r (first dir))]
                   [nc (+ c (second dir))])
               (set! res (+ res (/ (dfs nr nc (- k 1)) 8)))))
           (hash-set! dp (list r c k) res)
           res)]))
    (dfs row column k)))