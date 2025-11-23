#lang racket

(define (can-finish numCourses prerequisites)
  (define in-degree (make-vector numCourses 0))
  (define adj (make-vector numCourses '()))

  (for-each (lambda (prereq)
              (define course (car prereq))
              (define pre (cadr prereq))
              (vector-set! adj pre (cons course (vector-ref adj pre)))
              (vector-set! in-degree course (+ (vector-ref in-degree course) 1)))
            prerequisites)

  (define q-front '())
  (define q-back-reversed '())

  (define (q-empty?) (and (empty? q-front) (empty? q-back-reversed)))
  (define (q-enqueue! item) (set! q-back-reversed (cons item q-back-reversed)))
  (define (q-dequeue!)
    (when (empty? q-front)
      (set! q-front (reverse q-back-reversed))
      (set! q-back-reversed '()))
    (define item (car q-front))
    (set! q-front (cdr q-front))
    item)

  (for ([i (in-range numCourses)])
    (when (= (vector-ref in-degree i) 0)
      (q-enqueue! i)))

  (define count 0)
  (while (not (q-empty?))
    (define u (q-dequeue!))
    (set! count (+ count 1))

    (for-each (lambda (v)
                (vector-set! in-degree v (- (vector-ref in-degree v) 1))
                (when (= (vector-ref in-degree v) 0)
                  (q-enqueue! v)))
              (vector-ref adj u)))

  (= count numCourses))