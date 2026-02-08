(define (max-free-time schedule)
  (define events
    (sort (apply append schedule)
          (lambda (a b) (< (car a) (car b)))))

  (define (find-max-free events current-end max-free)
    (cond
      [(empty? events) max-free]
      [else
       (let* ([start (car (first events))]
              [end (cadr (first events))]
              [new-max-free (max max-free (- start current-end))]
              [new-current-end (max current-end end)])
         (find-max-free (rest events) new-current-end new-max-free))]))

  (if (empty? events)
      0
      (find-max-free (rest events) (cadr (first events)) 0)))