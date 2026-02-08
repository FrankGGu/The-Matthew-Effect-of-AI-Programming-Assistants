(define (maximum-groups team-sizes)
  (let* ([n (length team-sizes)]
         [sorted-sizes (sort team-sizes <)]
         [count 0]
         [group-size 0]
         [total-size 0])
    (for ([i (in-range n)])
      (set! group-size (+ group-size 1))
      (set! total-size (+ total-size (list-ref sorted-sizes i)))
      (when (>= total-size (sum (range 1 (+ group-size 1))))
        (set! count (+ count 1))))
    count))