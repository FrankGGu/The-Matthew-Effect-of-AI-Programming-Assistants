(define (earliestSecondToMarkIndices nums changeIndices)
  (define n (length nums))
  (define m (length changeIndices))

  (define (check t)
    (define marked (make-vector n #f))
    (define seconds (make-vector m #f))
    (for ([i (in-range t)])
      (vector-set! seconds i (- (list-ref changeIndices i) 1)))

    (define cur 0)
    (for ([i (in-range t)])
      (define idx (vector-ref seconds i))
      (cond
        [(not (vector-ref marked idx))
         (if (<= (vector-ref nums idx) cur)
             (begin
               (vector-set! marked idx #t)
               (set! cur 1))
             (set! cur (+ cur 1))))
        [else
         (set! cur (+ cur 1))]))

    (andmap vector-ref marked))

  (define (binary-search left right)
    (cond
      [(> left right) #f]
      [else
       (define mid (quotient (+ left right) 2))
       (if (check mid)
           (or mid (binary-search left (- mid 1)))
           (binary-search (+ mid 1) right))]))

  (let ([res (binary-search 1 m)])
    (if res res -1)))