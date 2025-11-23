#lang racket

(define (isEvenOddTree root)
  (define (dfs node level)
    (if (null? node)
        #t
        (let* ((val (send node value))
               (is-even? (even? level))
               (prev (if (null? (send level prev)) (if is-even? -1 +1) (send level prev))))
               (valid? (if (is-even? level)
                            (and (even? val) (or (= prev -1) (< val prev)))
                            (and (odd? val) (or (= prev +1) (> val prev))))))
          (if valid?
              (and (dfs (send node left) (add1 level))
                   (dfs (send node right) (add1 level)))
              #f))))
  (dfs root 0))