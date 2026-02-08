(define/contract (spiral-order matrix)
  (-> (listof (listof exact-integer?)) (listof exact-integer?))
  (if (null? matrix)
      '()
      (let loop ([matrix matrix]
                 [result '()])
        (cond
          [(null? matrix) (reverse result)]
          [(null? (car matrix)) (reverse result)]
          [else
           (let* ([first-row (car matrix)]
                  [rest-rows (cdr matrix)]
                  [new-result (append (reverse first-row) result)])
             (if (null? rest-rows)
                 (reverse new-result)
                 (let* ([last-column (map car rest-rows)]
                        [rest-matrix (map cdr rest-rows)]
                   (if (null? last-column)
                       (reverse new-result)
                       (let* ([new-result (append (reverse last-column) new-result)]
                              [last-row (reverse (car rest-matrix))]
                              [rest-matrix (cdr rest-matrix)]
                              [new-result (append last-row new-result)])
                         (if (null? rest-matrix)
                             (reverse new-result)
                             (let* ([first-column (reverse (map car rest-matrix))]
                                    [rest-matrix (map cdr rest-matrix)]
                                    [new-result (append first-column new-result)])
                               (loop rest-matrix new-result))))))))])))