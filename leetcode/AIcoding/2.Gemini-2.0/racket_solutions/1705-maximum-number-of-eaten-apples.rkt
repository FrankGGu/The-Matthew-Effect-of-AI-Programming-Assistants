(define (eaten-apples apples days)
  (let* ([n (length apples)]
         [pq (make-heap (lambda (a b) (< (car a) (car b))))]
         [eaten 0]
         [day 0])
    (letrec ([loop (lambda (day)
                      (cond
                        [(and (= day n) (heap-empty? pq)) eaten]
                        [else
                         (when (< day n)
                           (heap-add! pq (list (+ day (list-ref days day) -1) (list-ref apples day))))
                         (let loop2 ()
                           (cond
                             [(heap-empty? pq) #f]
                             [else
                              (let ([top (heap-top pq)])
                                (cond
                                  [(<= (car top) day)
                                   (heap-remove-top! pq)
                                   (loop2)]
                                  [else
                                   (let ([apples-left (car (cdr top))])
                                     (cond
                                       [(> apples-left 0)
                                        (set! eaten (+ eaten 1))
                                        (heap-remove-top! pq)
                                        (when (> apples-left 1)
                                          (heap-add! pq (list (car top) (list (- apples-left 1)))))
                                        (loop (+ day 1))]
                                       [else
                                        (heap-remove-top! pq)
                                        (loop2)])))])))]))]))]
      (loop day))))