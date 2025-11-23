(define (max-available-time meetings)
  (define sorted-meetings (sort (apply append meetings) < #:key car))
  (define heap (make-heap #:less-than? <))
  (define (helper sorted-meetings current-time)
    (cond
      [(empty? sorted-meetings) 0]
      [else
       (let* ([next-meeting (car sorted-meetings)]
              [start-time (car next-meeting)]
              [end-time (cadr next-meeting)])
         (cond
           [(heap-empty? heap)
            (heap-add! heap end-time)
            (helper (cdr sorted-meetings) start-time)]
           [else
            (let ([earliest-end-time (heap-top heap)])
              (cond
                [(>= start-time earliest-end-time)
                 (let ([available-time (- start-time earliest-end-time)])
                   (heap-remove-top! heap)
                   (heap-add! heap end-time)
                   (+ available-time (helper (cdr sorted-meetings) start-time)))]
                [else
                 (heap-add! heap end-time)
                 (helper (cdr sorted-meetings) current-time)]))]))]))))
  (helper sorted-meetings 0))