(define (find-servers-that-handled-most-number-of-requests k arrival load)
  (let* ([n (length k)]
         [available-servers (make-set (range n))]
         [busy-servers (make-heap <)]
         [requests-handled (make-vector n 0)])
    (for/list ([i (in-range n)])
      (let loop ([available-servers available-servers]
                 [busy-servers busy-servers])
        (cond
          [(empty? available-servers)
           (let* ([next-available (heap-top busy-servers)])
             (when (< (car next-available) (list-ref arrival i))
               (let* ([server-id (cdr next-available)])
                 (vector-set! requests-handled server-id (+ (vector-ref requests-handled server-id) 1))
                 (set-add! available-servers server-id)
                 (set-remove! available-servers server-id)
                 (set-add! available-servers server-id)
                 (loop available-servers (heap-remove busy-servers))))
             (unless (< (car next-available) (list-ref arrival i))
               (loop available-servers busy-servers)))]
          [else
           (let* ([start-server-index (modulo i k)]
                  [server-id (findf (lambda (x) (>= x start-server-index)) (set->list available-servers))])
             (cond
               [server-id
                (vector-set! requests-handled server-id (+ (vector-ref requests-handled server-id) 1))
                (set-remove! available-servers server-id)
                (heap-add! busy-servers (cons (+ (list-ref arrival i) (list-ref load i)) server-id))]
               [else
                (let ([server-id (findf (lambda (x) (< x start-server-index)) (set->list available-servers))])
                  (cond
                    [server-id
                     (vector-set! requests-handled server-id (+ (vector-ref requests-handled server-id) 1))
                     (set-remove! available-servers server-id)
                     (heap-add! busy-servers (cons (+ (list-ref arrival i) (list-ref load i)) server-id))]
                    [else
                     (let* ([next-available (heap-top busy-servers)])
                       (let* ([server-id (cdr next-available)])
                         (vector-set! requests-handled server-id (+ (vector-ref requests-handled server-id) 1))
                         (set-add! available-servers server-id)
                         (set-remove! available-servers server-id)
                         (set-add! available-servers server-id)
                         (heap-remove! busy-servers)
                         (set-remove! available-servers server-id)
                         (heap-add! busy-servers (cons (+ (list-ref arrival i) (list-ref load i)) server-id))))]))]))])]))
    (let* ([max-requests (apply max (vector->list requests-handled))]
           [result (for/list ([i (in-range n)] #:when (= (vector-ref requests-handled i) max-requests)) i)])
      result)))