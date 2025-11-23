(define (make-interval-set)
  (let ([intervals (box '())])
    (define (add interval)
      (let* ([new-intervals (list)]
             [start (car interval)]
             [end (cadr interval)])
        (define (merge-intervals current-intervals)
          (cond
            [(null? current-intervals)
             (append new-intervals (list interval))]
            [else
             (let* ([current-interval (car current-intervals)]
                    [current-start (car current-interval)]
                    [current-end (cadr current-interval)])
               (cond
                 [(> start current-end)
                  (append new-intervals (list current-interval))
                  (merge-intervals (cdr current-intervals))]
                 [(< end current-start)
                  (set! new-intervals (append new-intervals (list* interval current-interval (cdr current-intervals))))
                  (append new-intervals current-intervals)]
                 [else
                  (let ([new-start (min start current-start)]
                        [new-end (max end current-end)])
                    (define (find-overlapping-intervals remaining-intervals)
                      (cond
                        [(null? remaining-intervals)
                         (set! new_intervals (append new_intervals (list (list new-start new-end))))
                         (append new_intervals remaining-intervals)]
                        [else
                         (let* ([next-interval (car remaining-intervals)]
                                [next-start (car next-interval)]
                                [next-end (cadr next-interval)])
                           (cond
                             [(< new-end next-start)
                              (set! new_intervals (append new_intervals (list (list new-start new-end))))
                              (append new_intervals remaining-intervals)]
                             [(> new-start next-end)
                              (find-overlapping-intervals (cdr remaining-intervals))]
                             [else
                              (find-overlapping-intervals (cdr remaining-intervals))
                              (set! new-start (min new-start next-start))
                              (set! new-end (max new-end next-end))
                              (set! new_intervals (append new_intervals (list (list new-start new-end))))
                              ])))]))
                    (find-overlapping-intervals (cdr current-intervals))
                    )]))]))
        (merge-intervals (unbox intervals))
        (set-box! intervals new_intervals)))
    (define (count)
      (foldl + 0 (map (lambda (interval) (- (cadr interval) (car interval) 1)) (unbox intervals))))
    (list add count)))

(define (make-obj)
  (let ([intervals (make-interval-set)])
    (let ([add (car intervals)]
          [count (cadr intervals)])
      (struct obj (add count))
      (define this (obj add count))
      this)))

(provide make-obj)