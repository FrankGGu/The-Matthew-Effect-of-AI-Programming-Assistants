(define (minimum-time n relations time)
  (let* ((graph (make-vector (add1 n) '()))
         (indegree (make-vector (add1 n) 0))
         (start-times (make-vector (add1 n) 0)))
    (for ([r relations])
      (let ([prev (car r)]
            [next (cadr r)])
        (vector-set! graph prev (cons next (vector-ref graph prev)))
        (vector-set! indegree next (add1 (vector-ref indegree next)))))
    (let loop ([queue (for/list ([i (in-range 1 (add1 n))]
                                 #:when (= (vector-ref indegree i) 0))
                            i)]
               [max-time 0])
      (if (null? queue)
          max-time
          (let* ([node (car queue)]
                 [new-queue (cdr queue)]
                 [current-time (+ (vector-ref start-times node) (vector-ref time (sub1 node)))])
            (set! max-time (max max-time current-time))
            (for ([neighbor (in-list (vector-ref graph node))])
              (vector-set! start-times neighbor (max (vector-ref start-times neighbor) current-time))
              (vector-set! indegree neighbor (sub1 (vector-ref indegree neighbor)))
              (when (= (vector-ref indegree neighbor) 0)
                (set! new-queue (append new-queue (list neighbor)))))
            (loop new-queue max-time))))))