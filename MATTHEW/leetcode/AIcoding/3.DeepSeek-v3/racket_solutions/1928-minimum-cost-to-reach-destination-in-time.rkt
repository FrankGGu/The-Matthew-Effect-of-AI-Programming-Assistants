#lang racket

(define (min-cost max-time edges passing-fees)
  (define n (vector-length passing-fees))
  (define adj (make-vector n '()))
  (for ([edge edges])
    (define u (first edge))
    (define v (second edge))
    (define time (third edge))
    (vector-set! adj u (cons (list v time) (vector-ref adj u)))
    (vector-set! adj v (cons (list u time) (vector-ref adj v))))

  (define dp (make-vector n (make-hash)))
  (hash-set! (vector-ref dp 0) 0 (vector-ref passing-fees 0))

  (define pq (make-priority-queue (lambda (a b) (< (first a) (first b)))))
  (priority-queue-push! pq (list (vector-ref passing-fees 0) 0 0))

  (define result +inf.0)
  (let loop ()
    (unless (priority-queue-empty? pq)
      (define current (priority-queue-pop! pq))
      (define current-cost (first current))
      (define current-node (second current))
      (define current-time (third current))

      (when (and (= current-node (sub1 n)) (<= current-time max-time))
        (set! result (min result current-cost)))

      (when (< current-cost result)
        (for ([neighbor (vector-ref adj current-node)])
          (define next-node (first neighbor))
          (define edge-time (second neighbor))
          (define next-time (+ current-time edge-time))
          (when (<= next-time max-time)
            (define next-cost (+ current-cost (vector-ref passing-fees next-node)))
            (define next-hash (vector-ref dp next-node))
            (define found? #f)
            (for ([(t c) (in-hash next-hash)])
              (when (and (<= t next-time) (<= c next-cost))
                (set! found? #t)
                (break))
            (unless found?
              (hash-set! next-hash next-time next-cost)
              (priority-queue-push! pq (list next-cost next-node next-time))))))
      (loop)))

  (if (= result +inf.0) -1 (inexact->exact result)))