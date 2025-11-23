(define/contract (spiral-order matrix)
  (-> (listof (listof exact-integer?)) (listof exact-integer?))
  (if (null? matrix) '()
      (let loop ([matrix matrix]
                 [result '()])
        (cond [(null? matrix) (reverse result)]
              [(null? (car matrix)) (reverse result)]
              [else 
               (let* ([first-row (car matrix)]
                      [rest-rows (cdr matrix)]
                      [new-result (append (reverse first-row) result)])
                 (if (null? rest-rows)
                     (reverse new-result)
                     (let ([rotated (apply map list (map reverse rest-rows))])
                       (loop rotated new-result))))]))))