(define (job-scheduling start end profit)
  (let* ([jobs (map list start end profit)]
         [sorted-jobs (sort jobs (lambda (a b) (< (car a) (car b))))]
         [n (length sorted-jobs)]
         [dp (make-vector (add1 n) 0)])
    (for/fold ([i 1]
               [dp dp])
              ([job sorted-jobs])
      (let* ([s (car job)]
             [e (cadr job)]
             [p (caddr job)]
             [prev-idx (let loop ([l 0] [r (sub1 i)])
                         (if (<= l r)
                             (let ([mid (floor (/ (+ l r) 2))])
                               (if (<= (caadr (list-ref sorted-jobs mid)) s)
                                   (if (or (= mid (sub1 i)) (> (caadr (list-ref sorted-jobs (add1 mid))) s))
                                       mid
                                       (loop (add1 mid) r))
                                   (loop l (sub1 mid))))
                             -1))]
        (vector-set! dp i (max (vector-ref dp (sub1 i))
                               (+ p (if (= prev-idx -1) 0 (vector-ref dp (add1 prev-idx))))))
        (values (add1 i) dp)))
    (vector-ref dp n)))