(define (count-ways-to-group-overlapping-ranges ranges)
  (define sorted-ranges (sort ranges (lambda (a b) (< (car a) (car b)))))
  (define (merge-overlapping ranges)
    (if (null? ranges)
        '()
        (let loop ([curr-range (car ranges)]
                   [remaining-ranges (cdr ranges)]
                   [merged-ranges '()])
          (cond
            [(null? remaining-ranges) (reverse (cons curr-range merged-ranges))]
            [(<= (car (car remaining-ranges)) (cadr curr-range))
             (loop (list (min (car curr-range) (car (car remaining-ranges)))
                         (max (cadr curr-range) (cadr (car remaining-ranges))))
                   (cdr remaining-ranges)
                   merged-ranges)]
            [else (loop (car remaining-ranges)
                        (cdr remaining-ranges)
                        (reverse (cons curr-range merged-ranges)))]))))
  (define merged-ranges (merge-overlapping sorted-ranges))
  (modulo (expt 2 (length merged-ranges)) (+ 1 (expt 10 9))))