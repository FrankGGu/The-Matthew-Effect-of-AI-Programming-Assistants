#lang racket

(require data/queue)

(define (update-matrix mat)
  (define m (length mat))
  (define n (length (car mat)))

  (define dist (make-vector m))
  (define q (make-queue))

  (for ([r (in-range m)])
    (vector-set! dist r (make-vector n)))

  (for ([r (in-range m)])
    (for ([c (in-range n)])
      (if (= (list-ref (list-ref mat r) c) 0)
          (begin
            (vector-set! (vector-ref dist r) c 0)
            (enqueue! q (list r c)))
          (vector-set! (vector-ref dist r) c (+ m n)))))

  (define dr '(-1 1 0 0))
  (define dc '(0 0 -1 1))

  (while (not (queue-empty? q))
    (define-values (r c) (apply values (dequeue! q)))

    (define current-dist (vector-ref (vector-ref dist r) c))

    (for ([i (in-range 4)])
      (define nr (+ r (list-ref dr i)))
      (define nc (+ c (list-ref dc i)))

      (when (and (>= nr 0) (< nr m)
                 (>= nc 0) (< nc n))
        (when (> (vector-ref (vector-ref dist nr) nc) (+ current-dist 1))
          (vector-set! (vector-ref dist nr) nc (+ current-dist 1))
          (enqueue! q (list nr nc))))))

  (for/list ([row-vec (in-vector dist)])
    (vector->list row-vec)))