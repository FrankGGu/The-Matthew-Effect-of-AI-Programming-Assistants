(define (minimum-time tasks)
  (define sorted-tasks (sort tasks (lambda (a b) (< (cadr a) (cadr b)))))
  (define n (length tasks))
  (define last-day (cadr (last sorted-tasks)))
  (define used-days (make-vector (+ last-day 1) #f))
  (define count 0)

  (for ([task sorted-tasks])
    (define start (car task))
    (define end (cadr task))
    (define duration (caddr task))

    (define needed (- duration (count-true used-days start end)))

    (cond
      [(positive? needed)
       (let loop ([day end])
         (cond
           [(= needed 0) #t]
           [(>= day start)
            (cond
              [(not (vector-ref used-days day))
               (vector-set! used-days day #t)
               (set! count (+ count 1))
               (loop (- day 1))
               ]
              [else (loop (- day 1))]
              )]
           [else #t]
           ))]
      [else #t]))

  count)

(define (count-true used-days start end)
  (define count 0)
  (for ([i (in-range start (+ end 1))])
    (when (vector-ref used-days i)
      (set! count (+ count 1))))
  count)