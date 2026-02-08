(define/contract (find-max-value-of-equation points k)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (let loop ([i 0]
             [j 1]
             [max-val -inf.0]
             [queue (make-dequeue)])
    (cond
      [(>= j (length points)) (inexact->exact (floor max-val))]
      [(< (- (first (list-ref points j)) (first (list-ref points i))) k)
       (let* ([xi (first (list-ref points i))]
             [yi (second (list-ref points i))]
             [xj (first (list-ref points j))]
             [yj (second (list-ref points j))]
             [current-val (+ (- xj xi) yj yi)])
         (loop i (+ j 1) (max max-val current-val) queue)]
      [else
       (loop (+ i 1) j max-val queue)])))