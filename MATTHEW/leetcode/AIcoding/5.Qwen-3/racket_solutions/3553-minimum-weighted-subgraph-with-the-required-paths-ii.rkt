#lang racket

(define (min-weighted-subgraph n edges time limit)
  (define graph (make-hash))
  (for-each
   (lambda (edge)
     (let ([u (car edge)]
           [v (cadr edge)]
           [w (caddr edge)])
       (hash-set! graph u (cons (cons v w) (hash-ref graph u '())))
       (hash-set! graph v (cons (cons u w) (hash-ref graph v '())))))
   edges)
  (define (dijkstra start)
    (define dist (make-hash))
    (for ([i (in-range n)])
      (hash-set! dist i +inf.0))
    (hash-set! dist start 0)
    (define pq (list (cons 0 start)))
    (while (not (null? pq))
      (let* ([current (caar pq)]
             [node (cdar pq)]
             [neighbors (hash-ref graph node '())])
        (set! pq (cdr pq))
        (when (< current (hash-ref dist node))
          (for-each
           (lambda (neighbor)
             (let ([v (car neighbor)]
                   [w (cdr neighbor)])
               (let ([new-dist (+ current w)])
                 (when (< new-dist (hash-ref dist v))
                   (hash-set! dist v new-dist)
                   (set! pq (cons (cons new-dist v) pq))))))
           neighbors))))
    dist)
  (define (bfs start end)
    (define visited (make-hash))
    (define queue (list (cons start 0)))
    (while (not (null? queue))
      (let* ([current (caar queue)]
             [time (cdar queue)]
             [neighbors (hash-ref graph current '())])
        (set! queue (cdr queue))
        (when (and (not (hash-has-key? visited current))
                   (<= time limit))
          (hash-set! visited current time)
          (when (= current end)
            (return (hash-ref visited end)))
          (for-each
           (lambda (neighbor)
             (let ([v (car neighbor)]
                   [w (cdr neighbor)])
               (when (not (hash-has-key? visited v))
                 (set! queue (cons (cons v (+ time w)) queue)))))
           neighbors))))
    +inf.0)
  (define (find-min-path)
    (let ([dist1 (dijkstra 0)]
          [dist2 (dijkstra (- n 1))])
      (let ([min-time +inf.0])
        (for ([i (in-range n)])
          (when (and (<= (hash-ref dist1 i) time)
                     (<= (hash-ref dist2 i) time))
            (let ([total-time (+ (hash-ref dist1 i) (hash-ref dist2 i))])
              (when (< total-time min-time)
                (set! min-time total-time)))))
        (if (= min-time +inf.0)
            -1
            min-time))))
  (if (or (not (hash-has-key? graph 0)) (not (hash-has-key? graph (- n 1))))
      -1
      (find-min-path)))