(define (max-frequency nums k)
  (let* ([n (length nums)]
         [sorted-nums (vector-sort < (list->vector nums))]
         [left 0]
         [current-sum 0]
         [max-freq 0])
    (for ([right (in-range n)])
      (set! current-sum (+ current-sum (vector-ref sorted-nums right)))

      (let loop-shrink ()
        (when (> (* (add1 (- right left)) (vector-ref sorted-nums right))
                 (+ current-sum k))
          (set! current-sum (- current-sum (vector-ref sorted-nums left)))
          (set! left (add1 left))
          (loop-shrink)))

      (set! max-freq (max max-freq (add1 (- right left)))))
    max-freq))