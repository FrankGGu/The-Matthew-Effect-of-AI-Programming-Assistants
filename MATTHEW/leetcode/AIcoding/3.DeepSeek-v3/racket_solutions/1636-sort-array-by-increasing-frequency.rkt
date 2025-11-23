(define (frequency-sort nums)
  (let* ([freq (make-hash)]
         [count (lambda (x) (hash-ref freq x 0))]
         [sorted (sort nums (lambda (x y)
                              (let ([cx (count x)]
                                    [cy (count y)])
                                (if (= cx cy)
                                    (> x y)
                                    (< cx cy)))))])
    (for ([num nums])
      (hash-set! freq num (add1 (hash-ref freq num 0))))
    sorted))