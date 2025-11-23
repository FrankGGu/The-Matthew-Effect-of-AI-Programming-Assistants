(define (numBusesToDestination routes source target)
  (define graph (make-hash))
  (define n (length routes))
  (for/list [(i (in-range n))]
    (for/list [(stop (in-list (list-ref routes i)))]
      (when (not (hash-has-key? graph stop))
        (hash-set! graph stop '()))
      (hash-set! graph stop (cons i (hash-ref graph stop)))))

  (define q (make-queue))
  (define visited (make-hash))
  (define bus-visited (make-vector n #f))

  (when (hash-has-key? graph source)
    (enqueue! q (cons source 0))
    (hash-set! visited source #t))

  (let loop ()
    (if (queue-empty? q)
        -1
        (let* [(curr (dequeue! q))
               (stop (car curr))
               (buses (hash-ref graph stop '()))
               (count (cdr curr))]

          (if (= stop target)
              count
              (begin
                (for/list [(bus (in-list buses))]
                  (when (not (vector-ref bus-visited bus))
                    (vector-set! bus-visited bus #t)
                    (for/list [(next-stop (in-list (list-ref routes bus)))]
                      (when (not (hash-has-key? visited next-stop))
                        (enqueue! q (cons next-stop (+ count 1)))
                        (hash-set! visited next-stop #t))))
                  ))
                (loop))))))