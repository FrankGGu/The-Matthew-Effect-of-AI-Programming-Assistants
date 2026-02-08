(define (cut-off-tree forest)
  (let* ([m (length forest)]
         [n (length (car forest))]
         [trees (sort (flatten forest) <)]
         [trees (filter (lambda (x) (> x 1)) trees)]
         [start '(0 0)]
         (define (valid? r c)
           (and (>= r 0) (< r m) (>= c 0) (< c n)))
         (define (bfs start target)
           (let ([q (list start)]
                 [visited (make-hash)])
             (hash-set! visited start 0)
             (letrec ([loop ()]
                       [(when (empty? q) #f)
                        (let* ([curr (car q)]
                               [r (car curr)]
                               [c (cadr curr)]
                               [dist (hash-ref visited curr)])
                          (if (equal? curr target)
                              dist
                              (let ([neighbors (list (list (+ r 1) c)
                                                      (list (- r 1) c)
                                                      (list r (+ c 1))
                                                      (list r (- c 1)))])
                                (for-each (lambda (neighbor)
                                            (let* ([nr (car neighbor)]
                                                   [nc (cadr neighbor)])
                                              (when (and (valid? nr nc)
                                                         (not (hash-has-key? visited neighbor))
                                                         (> (list-ref (list-ref forest nr) nc) 0))
                                                (hash-set! visited neighbor (+ dist 1))
                                                (set! q (append q (list neighbor))))))
                                          neighbors)
                                (set! q (cdr q))
                                (loop))))]))
               (loop))))
         (letrec ([loop (trees total start)
                   [(when (empty? trees) total)
                    (let* ([tree-height (car trees)]
                           [target-row (index-of forest (lambda (row) (member tree-height row)))]
                           [target-col (index-of (list-ref forest target-row) (lambda (x) (= x tree-height))) ]
                           [target (list target-row target-col)]
                           [dist (bfs start target)])
                      (if dist
                          (let ()
                            (set! (list-ref (list-ref forest (car target)) (cadr target)) 1)
                            (loop (cdr trees) (+ total dist) target))
                          -1))]])
           (loop trees 0 start))))