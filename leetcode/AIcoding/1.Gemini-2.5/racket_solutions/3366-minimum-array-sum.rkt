#lang racket

(define (min-array-sum nums)
  (let* ([sorted-nums (sort nums <)])
    (let-values ([(final-sum final-prev-val)
                  (foldl (lambda (num acc-pair)
                           (let* ([current-sum (car acc-pair)]
                                  [prev-val (cdr acc-pair)])
                             (if (> num prev-val)
                                 (values (+ current-sum num) num)
                                 (let ([new-val (+ prev-val 1)])
                                   (values (+ current-sum new-val) new-val)))))
                         (values 0 -1)
                         sorted-nums)])
      final-sum)))