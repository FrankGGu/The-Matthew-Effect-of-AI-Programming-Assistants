(define (reward-top-k-students positive-feedback negative-feedback report students k)
  (define positive-set (set positive-feedback))
  (define negative-set (set negative-feedback))
  (define (calculate-score r)
    (let ([words (string-split r)])
      (foldl (lambda (w acc)
               (cond
                 [(set-member? positive-set w) (+ acc 3)]
                 [(set-member? negative-set w) (- acc 1)]
                 [else acc]))
             0
             words)))
  (let* ([scores (map calculate-score report)]
         [student-scores (map list students scores)]
         [sorted-student-scores (sort student-scores (lambda (a b)
                                                        (cond
                                                          [(> (cadr a) (cadr b)) #t]
                                                          [(= (cadr a) (cadr b)) (string<? (car a) (car b))]
                                                          [else #f])))]
         [top-k (take sorted-student-scores k)])
    (map car top-k)))