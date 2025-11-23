(define (max-value-of-equation points k)
  (define n (length points))
  (define (yi+yj xi+xj) (+ (second (list-ref points i)) (second (list-ref points j)) (abs (- (first (list-ref points i)) (first (list-ref points j))))))
  (define (solve)
    (let loop ([i 0] [max-val -inf.0] [queue '()])
      (cond
        [(>= i n) max-val]
        [else
         (let* ([xi (first (list-ref points i))]
                [yi (second (list-ref points i))])
           (let loop2 ([q queue] [max-q -inf.0] [new-queue '()])
             (cond
               [(null? q)
                (let ([new-queue-after-add (append new-queue (list i))])
                  (loop (+ i 1) (max max-val max-q) new-queue-after-add))]
               [else
                (let* ([j (car q)]
                       [xj (first (list-ref points j))]
                       [yj (second (list-ref points j))])
                  (if (> (- xi xj) k)
                      (loop2 (cdr q) max-q new-queue)
                      (let ([curr-q (+ yj (- xj))])
                        (if (> (+ yi xi) max-q)
                            (loop2 (cdr q) (+ yi xi) (append new-queue (list (car q))))
                            (loop2 (cdr q) max-q (append new-queue (list (car q))))))))])))]))))
  (solve))