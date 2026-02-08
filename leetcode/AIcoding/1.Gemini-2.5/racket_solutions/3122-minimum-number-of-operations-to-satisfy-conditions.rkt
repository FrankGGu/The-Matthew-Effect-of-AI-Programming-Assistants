(require racket/base)

(define (minimum-operations grid)
  (let* ([m (length grid)]
         [n (length (car grid))]
         [costs (build-list n
                            (lambda (j)
                              (let ([ones-in-col-j (for/sum ([i (in-range m)])
                                                     (list-ref (list-ref grid i) j))])
                                (list ones-in-col-j (- m ones-in-col-j)))))]
         [dp (make-vector n '())])

    (when (> n 0)
      ;; Base case for j = 0
      (vector-set! dp 0 (list (car (list-ref costs 0)) (cadr (list-ref costs 0))))

      ;; Iterate for j from 1 to n-1
      (for ([j (in-range 1 n)])
        (let* ([cost-j-0 (car (list-ref costs j))]
               [cost-j-1 (cadr (list-ref costs j))]
               [dp-prev (vector-ref dp (- j 1))]
               [dp-prev-0 (car dp-prev)]
               [dp-prev-1 (cadr dp-prev)])
          (vector-set! dp j (list (+ cost-j-0 dp-prev-1)
                                  (+ cost-j-1 dp-prev-0))))))

    ;; Final result
    (if (> n 0)
        (let ([last-dp (vector-ref dp (- n 1))])
          (min (car last-dp) (cadr last-dp)))
        0))) ; Handle empty grid case, though problem constraints usually prevent this