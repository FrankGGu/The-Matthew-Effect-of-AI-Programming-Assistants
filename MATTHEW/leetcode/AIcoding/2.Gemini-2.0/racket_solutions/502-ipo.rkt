(define (find-maximized-capital k w profits capital)
  (let* ([n (length profits)]
         [projects (make-vector n)]
         [priority-queue (make-heap < #:key (lambda (i) (vector-ref capital i)))]
         [available-projects (make-heap > #:key (lambda (i) (vector-ref profits i)))])

    (for ([i (in-range n)])
      (vector-set! projects i i)
      (heap-add! priority-queue i))

    (let loop ([k k] [w w])
      (cond
        [(zero? k) w]
        [else
         (let loop2 ()
           (if (and (not (heap-empty? priority-queue)) (<= (vector-ref capital (heap-top priority-queue)) w))
               (begin
                 (heap-add! available-projects (heap-remove! priority-queue))
                 (loop2))))

         (if (heap-empty? available-projects)
             w
             (loop (sub1 k) (+ w (vector-ref profits (heap-remove! available-projects)))))]))))