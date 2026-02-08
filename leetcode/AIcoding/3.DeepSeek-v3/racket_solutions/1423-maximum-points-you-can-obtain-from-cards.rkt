(define/contract (max-score card-points k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([n (length card-points)]
         [window-size (- n k)]
         [total (apply + card-points)]
         [window-sum (apply + (take card-points window-size))]
         [min-window-sum window-sum])
    (for ([i (in-range window-size n)])
      (set! window-sum (- (+ window-sum (list-ref card-points i))
                          (list-ref card-points (- i window-size)))))
      (when (< window-sum min-window-sum)
        (set! min-window-sum window-sum)))
    (- total min-window-sum)))