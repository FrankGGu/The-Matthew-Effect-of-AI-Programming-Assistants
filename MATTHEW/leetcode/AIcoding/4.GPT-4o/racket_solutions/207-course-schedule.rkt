(define (canFinish numCourses prerequisites)
  (define graph (make-vector numCourses '()))
  (define indegree (make-vector numCourses 0))

  (for ([prerequisite prerequisites])
    (let ([a (car prerequisite)]
          [b (cadr prerequisite)])
      (vector-set! graph a (cons b (vector-ref graph a)))
      (vector-set! indegree b (+ 1 (vector-ref indegree b)))))

  (define queue (make-queue))
  (for ([i (in-range numCourses)])
    (when (= (vector-ref indegree i) 0)
      (enqueue queue i)))

  (define count 0)

  (define (process-queue)
    (if (empty? queue)
        (void)
        (begin
          (define course (dequeue queue))
          (set! count (+ count 1))
          (for ([neighbor (vector-ref graph course)])
            (vector-set! indegree neighbor (- (vector-ref indegree neighbor) 1))
            (when (= (vector-ref indegree neighbor) 0)
              (enqueue queue neighbor)))
          (process-queue))))

  (process-queue)
  (= count numCourses))