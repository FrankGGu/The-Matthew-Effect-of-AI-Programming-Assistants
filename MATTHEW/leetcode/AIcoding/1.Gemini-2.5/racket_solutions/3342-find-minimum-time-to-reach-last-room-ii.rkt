#lang racket
(require data/heap)

(define (find-minimum-time m n rooms)
  (define room-map (make-hash))
  (for ([room rooms])
    (define r (list-ref room 0))
    (define c (list-ref room 1))
    (define t (list-ref room 2))
    (define key (cons r c))
    (hash-set! room-map key (max t (hash-ref room-map key 0))))

  (define dist (make-vector m))
  (for ([i (range m)])
    (vector-set! dist i (make-vector n +inf.0)))

  (vector-set! (vector-ref dist 0) 0 0)

  (define pq (heap-add (heap) (list 0 0 0)))

  (define dr '(-1 1 0 0))
  (define dc '(0 0 -1 1))

  (define target-r (sub1 m))
  (define target-c (sub1 n))

  (let loop ([current-pq pq])
    (cond
      [(heap-empty? current-pq)
       (let ([final-time (vector-ref (vector-ref dist target-r) target-c)])
         (if (eq? final-time +inf.0) -1 final-time))]
      [else
       (define-values (min-val rest-pq) (heap-remove-min current-pq))
       (define current-time (list-ref min-val 0))
       (define r (list-ref min-val 1))
       (define c (list-ref min-val 2))

       (when (> current-time (vector-ref (vector-ref dist r) c))
         (loop rest-pq))

       (define next-pq rest-pq)
       (for ([i (range 4)])
         (define nr (+ r (list-ref dr i)))
         (define nc (+ c (list-ref dc i)))

         (when (and (>= nr 0) (< nr m) (>= nc 0) (< nc n))
           (define time-to-enter-neighbor (+ current-time 1))
           (define restriction-time (hash-ref room-map (cons nr nc) 0))
           (define actual-arrival-time (max time-to-enter-neighbor restriction-time))

           (when (< actual-arrival-time (vector-ref (vector-ref dist nr) nc))
             (vector-set! (vector-ref dist nr) nc actual-arrival-time)
             (set! next-pq (heap-add next-pq (list actual-arrival-time nr nc))))))
       (loop next-pq)]))
)