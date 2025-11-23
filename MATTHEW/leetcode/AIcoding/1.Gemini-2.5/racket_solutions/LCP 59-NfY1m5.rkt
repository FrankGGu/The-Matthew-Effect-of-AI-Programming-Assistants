#lang racket

(require racket/list)

(define (bridge-crossing times)
  (let ([sorted-times (sort times <)])
    (define (solve current-times)
      (let ([n (length current-times)])
        (cond
          [(= n 0) 0]
          [(= n 1) (car current-times)]
          [(= n 2) (cadr current-times)]
          [(= n 3) (+ (car current-times) (cadr current-times) (caddr current-times))]
          [else
           (let* ([t1 (car current-times)]
                  [t2 (cadr current-times)]
                  [tn (last current-times)]
                  [tn-1 (list-ref current-times (- n 2))])
             (min
              (+ t2 t1 tn t2 (solve (take current-times (- n 2))))
              (+ tn t1 tn-1 t1 (solve (take current-times (- n 2)))))
             )])))
    (solve sorted-times)))