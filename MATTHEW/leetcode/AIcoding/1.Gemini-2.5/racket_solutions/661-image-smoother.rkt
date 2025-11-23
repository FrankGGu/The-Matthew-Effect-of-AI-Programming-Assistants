(define (image-smoother img)
  (define rows (length img))
  (define cols (length (car img)))

  (build-list rows
              (lambda (r)
                (build-list cols
                            (lambda (c)
                              (let-values (((sum count)
                                            (for/fold ([current-sum 0]
                                                       [current-count 0])
                                                      ([dr (in-range -1 2)]
                                                       [dc (in-range -1 2)])
                                              (let* ([nr (+ r dr)]
                                                     [nc (+ c dc)])
                                                (if (and (>= nr 0) (< nr rows)
                                                         (>= nc 0) (< nc cols))
                                                    (values (+ current-sum (list-ref (list-ref img nr) nc))
                                                            (+ current-count 1))
                                                    (values current-sum current-count))))))
                                (floor (/ sum count)))))))