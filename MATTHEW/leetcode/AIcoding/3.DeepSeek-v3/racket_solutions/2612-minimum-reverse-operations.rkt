#lang racket

(define/contract (min-reverse-operations n p banned-operations k)
  (-> exact-integer? exact-integer? (listof exact-integer?) exact-integer? (listof exact-integer?))
  (let* ([banned (make-hash)]
         [dist (make-vector n -1)]
         [q (make-queue)])
    (for ([b banned-operations])
      (hash-set! bann b #t))
    (vector-set! dist p 0)
    (enqueue! q p)
    (let loop ()
      (unless (queue-empty? q)
        (let ([u (dequeue! q)])
          (for ([i (in-range (max 0 (- u (- k 1))) (min (- n (- k 1)) (+ u 1))])
            (let* ([left i]
                   [right (+ i (- k 1))]
                   [v (+ left (- right u))])
              (when (and (not (hash-ref bann v #f))
                        (or (= (vector-ref dist v) -1)
                            (> (vector-ref dist v) (+ (vector-ref dist u) 1))))
                (vector-set! dist v (+ (vector-ref dist u) 1)
                (enqueue! q v))))
          (loop))))
    (vector->list dist)))