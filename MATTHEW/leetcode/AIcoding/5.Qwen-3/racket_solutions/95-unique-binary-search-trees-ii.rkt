#lang racket

(define (generate-trees n)
  (define (build start end)
    (if (> start end)
        (list #f)
        (for/list ([i (in-range start (add1 end))])
          (let ([left (build start (sub1 i))]
                [right (build (add1 i) end)])
            (for*/list ([l left] [r right])
              (cons i (cons l r))))))
  (if (= n 0)
      '()
      (build 1 n)))