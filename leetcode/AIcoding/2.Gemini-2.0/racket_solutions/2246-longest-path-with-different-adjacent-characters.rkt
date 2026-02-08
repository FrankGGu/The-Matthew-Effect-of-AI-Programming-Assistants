(define (longest-path s)
  (let* ((n (string-length s))
         (adj (make-vector n '()))
         (res (box 1)))

    (define (add-edge u v)
      (vector-set! adj u (cons v (vector-ref adj u))))

    (for ([i (in-range 1 n)])
      (add-edge (- i 1) i)
      (add-edge i (- i 1)))

    (define (dfs u parent)
      (let loop ([neighbors (vector-ref adj u)]
                 [max1 0]
                 [max2 0])
        (cond
          [(null? neighbors)
           (begin
             (set-box! res (max (unbox res) (+ max1 1)))
             (+ max1 1))]
          [else
           (let* ([v (car neighbors)])
             (if (or (= v parent) (char=? (string-ref s u) (string-ref s v)))
                 (loop (cdr neighbors) max1 max2)
                 (let ([len (dfs v u)])
                   (cond
                     [(> len max1)
                      (loop (cdr neighbors) len max1)]
                     [(> len max2)
                      (loop (cdr neighbors) max1 len)]
                     [else
                      (loop (cdr neighbors) max1 max2)]))))]))
      (set-box! res (max (unbox res) (+ max1 max2 1)))
      (+ max1 1)))

    (dfs 0 -1)
    (unbox res)))