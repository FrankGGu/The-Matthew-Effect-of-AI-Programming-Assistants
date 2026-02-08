(define (minimumTime tasks workers pills)
  (define (check time)
    (define (helper tasks workers pills used-pills)
      (cond
        [(empty? tasks) #t]
        [(zero? workers) #f]
        [else
         (define possible-tasks
           (filter (lambda (task) (<= (car task) time)) tasks))
         (cond
           [(empty? possible-tasks) #f]
           [else
            (let loop ([remaining-tasks (sort possible-tasks < #:key cdr)])
              (cond
                [(empty? remaining-tasks) #f]
                [else
                 (define task (car remaining-tasks))
                 (define task-time (car task))
                 (define task-difficulty (cdr task))
                 (cond
                   [(>= task-difficulty (apply min (map car tasks)))
                    (if (helper (remove task tasks) (sub1 workers) pills used-pills)
                        #t
                        (loop (cdr remaining-tasks)))]
                   [else
                    (cond
                      [(and (> pills used-pills) (> workers 1))
                       (if (helper (remove task tasks) (sub1 workers) pills (add1 used-pills))
                           #t
                           (if (helper (remove task tasks) (sub1 workers) pills used-pills)
                               #t
                               (loop (cdr remaining-tasks))))]
                      [else
                       (if (helper (remove task tasks) (sub1 workers) pills used-pills)
                           #t
                           (loop (cdr remaining-tasks)))])])]))]))]))
    (helper tasks workers pills 0))

  (define (binary-search left right)
    (cond
      [(> left right) right]
      [else
       (let* ([mid (floor (/ (+ left right) 2))])
         (if (check tasks workers pills mid)
             (binary-search left (sub1 mid))
             (binary-search (add1 mid) right)))]))

  (binary-search 1 (apply max (map car tasks))))