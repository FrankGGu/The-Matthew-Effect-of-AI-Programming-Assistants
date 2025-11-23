(define (generate numRows)
  (if (zero? numRows)
      '()
      (let loop ([row-num 1] [result '()])
        (if (> row-num numRows)
            result
            (let ([prev-row (if (null? result) '() (car result))])
              (let ([new-row (make-row row-num prev-row)])
                (loop (+ row-num 1) (cons new-row result))))))))

(define (make-row row-num prev-row)
  (cond
    [(= row-num 1) '(1)]
    [else
     (let loop ([i 0] [new-row '()])
       (cond
         [(= i row-num) (reverse new-row)]
         [(= i 0) (loop (+ i 1) '(1))]
         [else
          (let ([val (+ (list-ref prev-row (- i 1)) (list-ref prev-row i))])
            (loop (+ i 1) (cons val new-row)))]))]))