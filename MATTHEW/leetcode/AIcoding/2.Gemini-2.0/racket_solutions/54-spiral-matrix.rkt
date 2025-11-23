(define (spiral-order matrix)
  (define (spiral-helper matrix row-start row-end col-start col-end acc)
    (cond
      [(or (> row-start row-end) (> col-start col-end)) acc]
      [else
       (let* ([top-row (list-ref matrix row-start)]
              [right-col (map (lambda (row) (list-ref row col-end)) (range row-start (add1 row-end)))]
              [bottom-row (reverse (list-ref matrix row-end))]
              [left-col (reverse (map (lambda (row) (list-ref row col-start)) (range row-start (add1 row-end))))])
         (let* ([new-acc (append acc (take top-row (- (length top-row) (if (= col-start col-end) 1 0))))]
                [new-acc (append new-acc (take right-col (- (length right-col) (if (= row-start row-end) 1 0))))]
                [new-acc (append new-acc (take bottom-row (- (length bottom-row) (if (= col-start col-end) 1 0))))]
                [new-acc (append new-acc (take left-col (- (length left-col) (if (= row-start row-end) 1 0))))])
           (spiral-helper matrix (add1 row-start) (sub1 row-end) (add1 col-start) (sub1 col-end) new-acc)))]))

  (if (null? matrix)
      '()
      (spiral-helper matrix 0 (sub1 (length matrix)) 0 (sub1 (length (car matrix))) '())))