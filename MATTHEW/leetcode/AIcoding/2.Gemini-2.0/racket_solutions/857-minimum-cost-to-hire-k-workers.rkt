(define (mincostToHireWorkers quality wage k)
  (let* ([n (length quality)]
         [workers (map list quality wage)]
         [ratios (sort (map (lambda (worker) (/ (list-ref worker 1) (list-ref worker 0))) workers) <)]
         [min-cost (mutable-box +inf.0)]
         [pq (make-heap >)])
    (for/fold ([curr-quality 0]
               [i 0])
              ([ratio ratios])
      (let loop ([j 0])
        (cond
          [(>= j n) (values curr-quality i)]
          [else
           (let ([worker (list-ref workers j)])
             (if (= ratio (/ (list-ref worker 1) (list-ref worker 0)))
                 (begin
                   (heap-add! pq (list-ref worker 0))
                   (set! curr-quality (+ curr-quality (list-ref worker 0)))
                   (if (> (heap-count pq) k)
                       (let ([largest (heap-remove-min! pq)])
                         (set! curr-quality (- curr-quality largest))))
                   (if (= (heap-count pq) k)
                       (set-box! min-cost (min (unbox min-cost) (* ratio curr-quality))))
                   (loop (+ j 1)))
                 (loop (+ j 1))))))))
    (unbox min-cost)))