(define (minimum-time-required jobs k)
  (define (possible? time)
    (define workers (make-vector k 0))
    (define (assign-job idx)
      (cond
        [(>= idx (length jobs)) #t]
        [else
         (let loop ([i 0])
           (cond
             [(>= i k) #f]
             [else
              (vector-set! workers i (+ (vector-ref workers i) (list-ref jobs idx)))
              (cond
                [(<= (vector-ref workers i) time)
                 (cond
                   [(assign-job (+ idx 1)) #t]
                   [else
                    (vector-set! workers i (- (vector-ref workers i) (list-ref jobs idx)))
                    (loop (+ i 1))])]
                [else
                 (vector-set! workers i (- (vector-ref workers i) (list-ref jobs idx)))
                 (loop (+ i 1))])]))]))
    (assign-job 0))

  (define (binary-search low high)
    (cond
      [(> low high) low]
      [else
       (let ([mid (floor (+ low high) 2)])
         (cond
           [(possible? mid) (binary-search low (- mid 1))]
           [else (binary-search (+ mid 1) high)]))]))

  (define sum-jobs (apply + jobs))
  (binary-search (apply max jobs) sum-jobs))