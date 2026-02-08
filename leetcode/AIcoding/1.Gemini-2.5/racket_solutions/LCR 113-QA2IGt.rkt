#lang racket

(require data/queue)

(define (find-order numCourses prerequisites)
  (define graph (make-vector numCourses '()))
  (define in-degree (make-vector numCourses 0))

  ;; Build graph and calculate in-degrees
  (for-each
   (lambda (prereq)
     (define course (car prereq))
     (define pre (cadr prereq))
     (vector-set! graph pre (cons course (vector-ref graph pre)))
     (vector-set! in-degree course (+ (vector-ref in-degree course) 1)))
   prerequisites)

  ;; Initialize queue with courses having 0 in-degree
  (define q (make-queue))
  (for ([i (in-range numCourses)])
    (when (= (vector-ref in-degree i) 0)
      (enqueue! q i)))

  ;; Perform topological sort
  (define result-list '())
  (define count 0)
  (while (not (queue-empty? q))
    (define u (dequeue! q))
    (set! result-list (cons u result-list))
    (set! count (+ count 1))
    (for-each
     (lambda (v)
       (vector-set! in-degree v (- (vector-ref in-degree v) 1))
       (when (= (vector-ref in-degree v) 0)
         (enqueue! q v)))
     (vector-ref graph u)))

  ;; Check for cycle and reverse the result list
  (if (= count numCourses)
      (reverse result-list)
      '()))