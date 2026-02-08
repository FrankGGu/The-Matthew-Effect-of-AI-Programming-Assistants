#lang racket

(define (findShortestCycle n edges)
  (define adj (make-vector n '()))
  (for ([edge edges])
    (let ([u (car edge)]
          [v (cadr edge)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v)))))

  (define min-cycle +inf.0)

  (define (bfs start)
    (define dist (make-vector n +inf.0))
    (define parent (make-vector n -1))
    (define q (make-queue))
    (vector-set! dist start 0)
    (enqueue! q start)

    (let loop ()
      (unless (queue-empty? q)
        (let ([u (dequeue! q)])
          (for ([v (vector-ref adj u)])
            (cond
              [(= (vector-ref dist v) +inf.0)
               (vector-set! dist v (+ (vector-ref dist u) 1))
               (vector-set! parent v u)
               (enqueue! q v)]
              [(not (= (vector-ref parent u) v))
               (set! min-cycle (min min-cycle (+ (vector-ref dist u) (vector-ref dist v) 1)))])))
        (loop))))

  (for ([i (in-range n)])
    (bfs i)

  (if (= min-cycle +inf.0) -1 min-cycle))