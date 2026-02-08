#lang racket

(require racket/vector)
(require racket/queue)

(define (minimum-obstacle-removal-to-reach-corner grid-list)
  (define grid (list->vector (map list->vector grid-list)))

  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  (define dist (make-vector m))
  (for ([i (in-range m)])
    (vector-set! dist i (make-vector n #f)))

  (define deque (make-deque))

  (vector-set! (vector-ref dist 0) 0 0)
  (deque-push-front! deque (list 0 0))

  (define dr (list -1 1 0 0))
  (define dc (list 0 0 -1 1))

  (let loop ()
    (unless (deque-empty? deque)
      (define current-pos (deque-pop-front! deque))
      (define r (first current-pos))
      (define c (second current-pos))
      (define current-cost (vector-ref (vector-ref dist r) c))

      (for ([i (in-range 4)])
        (define nr (+ r (list-ref dr i)))
        (define nc (+ c (list-ref dc i)))

        (when (and (>= nr 0) (< nr m)
                   (>= nc 0) (< nc n))
          (define obstacle-cost (vector-ref (vector-ref grid nr) nc))
          (define new-cost (+ current-cost obstacle-cost))

          (when (or (not (vector-ref (vector-ref dist nr) nc))
                    (< new-cost (vector-ref (vector-ref dist nr) nc)))
            (vector-set! (vector-ref dist nr) nc new-cost)
            (if (= obstacle-cost 0)
                (deque-push-front! deque (list nr nc))
                (deque-push-back! deque (list nr nc)))))
      (loop)))

  (vector-ref (vector-ref dist (- m 1)) (- n 1)))