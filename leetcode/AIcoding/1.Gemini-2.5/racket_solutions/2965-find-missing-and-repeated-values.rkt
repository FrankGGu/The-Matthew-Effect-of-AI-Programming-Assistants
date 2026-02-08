#lang racket

(require racket/set)

(define (find-missing-and-repeated-values nums)
  (let* ([n (length nums)]
         [expected-sum (quotient (* n (+ n 1)) 2)]
         [seen-numbers (set)]
         [repeated -1]
         [current-sum 0])
    (for-each (lambda (num)
                (when (set-member? seen-numbers num)
                  (set! repeated num))
                (set-add! seen-numbers num)
                (set! current-sum (+ current-sum num)))
              nums)
    (let ([missing (- expected-sum (- current-sum repeated))])
      (list repeated missing))))