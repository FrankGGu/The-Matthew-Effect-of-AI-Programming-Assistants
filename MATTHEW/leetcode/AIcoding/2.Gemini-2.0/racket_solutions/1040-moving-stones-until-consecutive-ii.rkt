(define (num-moves-stones-ii stones)
  (let* ((n (length stones))
         (sorted-stones (sort stones <))
         (max-moves (- (max (- (list-ref sorted-stones (- n 2)) (list-ref sorted-stones 0) (- n 2))
                         (- (list-ref sorted-stones (- n 1)) (list-ref sorted-stones 1) (- n 2))))
         (min-moves (let loop ((left 0) (right 0) (count n))
                      (cond
                        ((= right n) count)
                        ((< (- (list-ref sorted-stones right) (list-ref sorted-stones left) 1) n)
                         (loop left (+ right 1) (min count (- n (- right left)))))
                        (else
                         (if (= (- right left) (- n 1))
                             (if (= (- (list-ref sorted-stones right) (list-ref sorted-stones left) 1) (- n 1))
                                 (if (= (- right left) (- n 2))
                                     count
                                     2)
                                 count)
                             (loop (+ left 1) right count)))))))
    (list min-moves max-moves)))