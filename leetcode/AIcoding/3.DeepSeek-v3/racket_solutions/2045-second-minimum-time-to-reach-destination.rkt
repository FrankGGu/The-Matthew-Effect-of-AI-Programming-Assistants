#lang racket

(define (second-minimum n edges time change)
  (define adj (make-vector (add1 n) '()))
  (for ([edge edges])
    (let ([u (first edge)]
          [v (second edge)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v)))))

  (define min-time (make-vector (add1 n) +inf.0))
  (define second-min (make-vector (add1 n) +inf.0))
  (vector-set! min-time 1 0)

  (define q (make-queue))
  (enqueue! q (cons 1 0))

  (let loop ()
    (unless (queue-empty? q)
      (let* ([node (car (dequeue! q))]
             [current-time (cdr (dequeue! q))]
             [next-nodes (vector-ref adj node)])
        (for ([next next-nodes])
          (let* ([total-change (quotient current-time change)]
                 [new-time (if (even? total-change)
                               (+ current-time time)
                               (+ (* (add1 total-change) change) time))])
            (cond
              [(< new-time (vector-ref min-time next))
               (vector-set! second-min next (vector-ref min-time next))
               (vector-set! min-time next new-time)
               (enqueue! q (cons next new-time))]
              [(and (> new-time (vector-ref min-time next))
                    (< new-time (vector-ref second-min next)))
               (vector-set! second-min next new-time)
               (enqueue! q (cons next new-time))]))))
      (loop)))

  (if (= (vector-ref second-min n) +inf.0)
      -1
      (vector-ref second-min n)))