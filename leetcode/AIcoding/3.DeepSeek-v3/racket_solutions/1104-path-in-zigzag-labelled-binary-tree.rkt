(define (path-in-zigzag-tree label)
  (let loop ([label label] [path '()])
    (if (= label 1)
        (cons 1 path)
        (let* ([level (floor (/ (log label) (log 2)))]
               [parent (quotient (+ (expt 2 level) (expt 2 (add1 level)) 2)
                       (quotient (- label (expt 2 level)) 1)])
          (loop parent (cons label path))))))