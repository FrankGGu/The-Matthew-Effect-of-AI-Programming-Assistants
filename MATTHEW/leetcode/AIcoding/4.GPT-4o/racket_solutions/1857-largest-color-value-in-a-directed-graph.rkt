#lang racket

(define (largestColorValue colors edges)
  (define n (length colors))
  (define graph (make-vector n '()))
  (define indegree (make-vector n 0))

  (for ([edge edges])
    (define u (car edge))
    (define v (cadr edge))
    (vector-set! graph u (cons v (vector-ref graph u)))
    (vector-set! indegree v (+ 1 (vector-ref indegree v))))

  (define queue (make-queue))
  (define dp (make-vector n (make-vector 26 0)))

  (for ([i (in-range n)])
    (when (= (vector-ref indegree i) 0)
      (queue-enqueue! queue i)))

  (define result 0)

  (define (bfs)
    (while (not (queue-empty? queue))
      (define u (queue-dequeue! queue))
      (define color-index (- (char->integer (vector-ref colors u)) (char->integer #\a)))
      (vector-set! (vector-ref dp u) color-index (+ 1 (vector-ref (vector-ref dp u) color-index)))
      (set! result (max result (vector-ref (vector-ref dp u) color-index)))

      (for ([v (vector-ref graph u)])
        (vector-set! indegree v (- (vector-ref indegree v) 1))
        (for ([j (in-range 26)])
          (vector-set! (vector-ref dp v) j (max (vector-ref (vector-ref dp v) j) (vector-ref (vector-ref dp u) j))))
        (when (= (vector-ref indegree v) 0)
          (queue-enqueue! queue v)))))

  (bfs)
  (if (for/or ([i (in-range n)]) (> (vector-ref indegree i) 0))
      -1
      result))

(define (make-queue)
  (list 'queue '()))

(define (queue-enqueue! queue x)
  (set-cdr! queue (cons x (cdr queue)))

(define (queue-dequeue! queue)
  (define items (cdr queue))
  (set-cdr! queue (cdr items))
  (car items))

(define (queue-empty? queue)
  (null? (cdr queue)))