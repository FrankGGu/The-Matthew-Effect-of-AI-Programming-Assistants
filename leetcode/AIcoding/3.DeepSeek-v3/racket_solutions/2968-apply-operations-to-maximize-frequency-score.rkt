(define/contract (max-frequency-score nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([nums (sort nums <)]
         [n (length nums)]
         [prefix (make-vector (+ n 1) 0)])
    (for ([i (in-range n)])
      (vector-set! prefix (+ i 1) (+ (vector-ref prefix i) (list-ref nums i))))
    (define (sum l r)
      (- (vector-ref prefix (+ r 1)) (vector-ref prefix l)))
    (let loop ([left 0] [right 0] [res 0])
      (if (>= right n)
          res
          (let* ([window-length (+ (- right left) 1)]
                 [total (sum left right)]
                 [target (* (list-ref nums right) window-length)]
                 [cost (- target total)])
            (if (<= cost k)
                (loop left (+ right 1) (max res window-length))
                (loop (+ left 1) right res)))))))