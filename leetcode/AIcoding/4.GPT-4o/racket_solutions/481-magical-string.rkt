(define (magicalString n)
  (define magical (list 1 2 2))
  (define (build-magic len)
    (if (< (length magical) len)
        (let ([next (if (= (list-ref magical (- (length magical) 1)) 1) 2 1)]
              [count (list-ref magical (- (length magical) 1))])
          (for ([i (in-range count)])
            (set! magical (append magical (list next))))
          (build-magic len)))
    (if (= (length magical) len)
        magical
        (take magical len)))
  (define final-string (build-magic n))
  (define count (foldl (lambda (x acc) (if (= x 1) (+ acc 1) acc)) 0 final-string))
  count)

(magicalString 6)