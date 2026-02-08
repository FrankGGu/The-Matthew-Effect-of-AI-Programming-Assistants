(define (erase-overlap-intervals intervals)
  (if (empty? intervals)
      0
      (let* ([sorted-intervals (sort intervals
                                     (lambda (a b)
                                       (let ([end-a (second a)]
                                             [end-b (second b)])
                                         (if (= end-a end-b)
                                             (< (first a) (first b))
                                             (< end-a end-b)))))])
        (let loop ([remaining (cdr sorted-intervals)]
                   [removed-count 0]
                   [last-end (second (car sorted-intervals))])
          (if (empty? remaining)
              removed-count
              (let* ([current-interval (car remaining)]
                     [current-start (first current-interval)]
                     [current-end (second current-interval)])
                (if (< current-start last-end)
                    (loop (cdr remaining)
                          (add1 removed-count)
                          last-end)
                    (loop (cdr remaining)
                          removed-count
                          current-end))))))))