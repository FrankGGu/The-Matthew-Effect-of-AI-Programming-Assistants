(define (max-free-time meetings)
  (if (< (length meetings) 2)
      0
      (let* ((sorted-meetings (sort meetings (lambda (a b) (< (car a) (car b)))))
             (merged-meetings
              (reverse
               (foldl (lambda (current-interval acc)
                        (if (empty? acc)
                            (list current-interval)
                            (let* ((last-merged (car acc))
                                   (last-end (cadr last-merged))
                                   (current-start (car current-interval))
                                   (current-end (cadr current-interval)))
                              (if (<= current-start last-end)
                                  (cons (list (car last-merged) (max last-end current-end)) (cdr acc))
                                  (cons current-interval acc)))))
                      '()
                      sorted-meetings)))
        (if (< (length merged-meetings) 2)
            0
            (let loop ((rest (cdr merged-meetings))
                       (prev (car merged-meetings))
                       (max-gap 0))
              (if (empty? rest)
                  max-gap
                  (let* ((current (car rest))
                         (gap (- (car current) (cadr prev))))
                    (loop (cdr rest) current (max max-gap gap)))))))))