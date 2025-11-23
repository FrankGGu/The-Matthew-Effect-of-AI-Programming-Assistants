(define (spiral-order matrix)
  (let* ((m (length matrix))
         (n (if (empty? matrix) 0 (length (car matrix)))))
    (if (or (= m 0) (= n 0))
        '()
        (let loop ((row-start 0)
                   (row-end (- m 1))
                   (col-start 0)
                   (col-end (- n 1))
                   (acc '()))
          (if (or (> row-start row-end) (> col-start col-end))
              (reverse acc)
              (let* (;; Traverse right
                     (acc-after-right
                      (for/fold ((current-acc acc))
                                ([j (in-range col-start (+ col-end 1))])
                        (cons (list-ref (list-ref matrix row-start) j) current-acc)))
                     (next-row-start (+ row-start 1)))
                (if (> next-row-start row-end)
                    (reverse acc-after-right)
                    (let* (;; Traverse down
                           (acc-after-down
                            (for/fold ((current-acc acc-after-right))
                                      ([i (in-range next-row-start (+ row-end 1))])
                              (cons (list-ref (list-ref matrix i) col-end) current-acc)))
                           (next-col-end (- col-end 1)))
                      (if (> col-start next-col-end)
                          (reverse acc-after-down)
                          (let* (;; Traverse left
                                 (acc-after-left
                                  (for/fold ((current-acc acc-after-down))
                                            ([j (in-range next-col-end (- col-start 1) -1)])
                                    (cons (list-ref (list-ref matrix row-end) j) current-acc)))
                                 (next-row-end (- row-end 1)))
                            (if (> next-row-start next-row-end)
                                (reverse acc-after-left)
                                (let* (;; Traverse up
                                       (acc-after-up
                                        (for/fold ((current-acc acc-after-left))
                                                  ([i (in-range next-row-end (- next-row-start 1) -1)])
                                          (cons (list-ref (list-ref matrix i) col-start) current-acc)))
                                       (next-col-start (+ col-start 1)))
                                  (loop next-row-start
                                        next-row-end
                                        next-col-start
                                        next-col-end
                                        acc-after-up)))))))))))))