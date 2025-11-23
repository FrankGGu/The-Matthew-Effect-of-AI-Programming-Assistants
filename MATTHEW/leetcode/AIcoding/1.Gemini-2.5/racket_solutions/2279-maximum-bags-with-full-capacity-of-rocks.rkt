(define (maximum-bags capacity current additionalRocks)
  (let* ([rocks-needed (map - capacity current)]
         [sorted-rocks-needed (sort rocks-needed <)])
    (let ([result (foldl (lambda (needed-for-bag acc)
                           (let ([current-full-bags (car acc)]
                                 [current-remaining-rocks (cadr acc)])
                             (if (>= current-remaining-rocks needed-for-bag)
                                 (list (+ current-full-bags 1)
                                       (- current-remaining-rocks needed-for-bag))
                                 acc)))
                         (list 0 additionalRocks)
                         sorted-rocks-needed)])
      (car result))))