(define (maximum-groups batteries)
  (let* ([sorted-batteries (sort batteries <)])
    (let-values ([(current-sum groups-formed)
                  (foldl (lambda (battery acc)
                           (let* ([current-sum (car acc)]
                                  [groups-formed (cdr acc)]
                                  [new-current-sum (+ current-sum battery)]
                                  [required-for-next-group (+ groups-formed 1)])
                             (if (>= new-current-sum required-for-next-group)
                                 (cons (- new-current-sum required-for-next-group)
                                       (+ groups-formed 1))
                                 (cons new-current-sum
                                       groups-formed))))
                         (cons 0 0) ; initial (current-sum . groups-formed)
                         sorted-batteries)])
      groups-formed)))