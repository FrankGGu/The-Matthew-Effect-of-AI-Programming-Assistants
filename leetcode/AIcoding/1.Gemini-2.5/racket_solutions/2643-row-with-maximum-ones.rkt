#lang racket

(define (row-with-maximum-ones mat)
  (for/fold ([max-info (list 0 0)]) ; max-info stores (list best-row-index max-ones-count)
            ([row mat]
             [row-idx (in-naturals)])
    (let* ([current-ones (for/sum ([val row]) (if (= val 1) 1 0))]
           [current-best-row-idx (car max-info)]
           [current-max-ones (cadr max-info)])
      (if (> current-ones current-max-ones)
          (list row-idx current-ones)
          max-info))))