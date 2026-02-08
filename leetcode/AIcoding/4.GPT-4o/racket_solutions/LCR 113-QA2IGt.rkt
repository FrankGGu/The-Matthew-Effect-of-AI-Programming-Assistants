(define (findOrder numCourses prerequisites)
  (define adj (make-vector numCourses '()))
  (define in-degree (make-vector numCourses 0))

  (for ([p prerequisites])
    (let ([u (car p)]
          [v (cadr p)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! in-degree v (+ 1 (vector-ref in-degree v)))))

  (define queue (make-queue))
  (for ([i (in-range numCourses)])
    (when (= (vector-ref in-degree i) 0)
      (enqueue queue i)))

  (define order '())
  (define count 0)

  (define (topological-sort)
    (if (queue-empty? queue)
        (if (= count numCourses)
            (reverse order)
            '())
        (begin
          (define node (dequeue queue))
          (set! order (cons node order))
          (set! count (+ count 1))
          (for ([neighbor (vector-ref adj node)])
            (vector-set! in-degree neighbor (- (vector-ref in-degree neighbor) 1))
            (when (= (vector-ref in-degree neighbor) 0)
              (enqueue queue neighbor)))
          (topological-sort))))

  (topological-sort))

(define (make-queue)
  (list '()))

(define (enqueue queue item)
  (set! queue (append queue (list item)))

(define (dequeue queue)
  (let ([item (car queue)])
    (set! queue (cdr queue))
    item))

(define (queue-empty? queue)
  (null? queue))