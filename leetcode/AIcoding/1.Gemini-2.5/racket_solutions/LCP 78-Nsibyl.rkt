#lang racket

(require data/heap)

(define (minimum-time-to-visit-a-cell-in-a-grid grid)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  (if (and (= m 1) (= n 1))
      0
      (let* ()
        (define initial-depart-time (vector-ref (vector-ref grid 0) 0))
        (define initial-arrival-time-at-neighbor (+ initial-depart-time 1))
        (define num-possible-first-moves 0)

        (when (> n 1)
          (when (>= initial-arrival-time-at-neighbor (vector-ref (vector-ref grid 0) 1))
            (set! num-possible-first-moves (+ num-possible-first-moves 1))))
        (when (> m 1)
          (when (>= initial-arrival-time-at-neighbor (vector-ref (vector-ref grid 1) 0))
            (set! num-possible-first-moves (+ num-possible-first-moves 1))))

        (if (= num-possible-first-moves 0)
            -1
            (let ()
              (define +inf.0 (expt 10 18))
              (define dist (make-vector m))
              (for ([i (in-range m)])
                (vector-set! dist i (make-vector n +inf.0)))

              (define pq (make-heap (lambda (a b) (< (car a) (car b)))))

              (define initial-time-at-00 (vector-ref (vector-ref grid 0) 0))
              (vector-set! (vector-ref dist 0) 0 initial-time-at-00)
              (heap-add! pq (list initial-time-at-00 0 0))

              (define dr (list 0 0 1 -1))
              (define dc (list 1 -1 0 0))

              (let loop ()
                (when (not (heap-empty? pq))
                  (define current (heap-min-key pq))
                  (heap-remove-min! pq)

                  (define d (car current))
                  (define r (cadr current))
                  (define c (caddr current))

                  (when (> d (vector-ref (vector-ref dist r) c))
                    (loop))

                  (for ([i (in-range 4)])
                    (define nr (+ r (vector-ref dr i)))
                    (define nc (+ c (vector-ref dc i)))

                    (when (and (>= nr 0) (< nr m) (>= nc 0) (< nc n))
                      (define arrival-at-neighbor (+ d 1))
                      (define time-to-be-ready-at-neighbor (max arrival-at-neighbor (vector-ref (vector-ref grid nr) nc)))

                      (when (and (< arrival-at-neighbor (vector-ref (vector-ref grid nr) nc))
                                 (odd? (- (vector-ref (vector-ref grid nr) nc) arrival-at-neighbor)))
                        (set! time-to-be-ready-at-neighbor (+ time-to-be-ready-at-neighbor 1)))

                      (when (< time-to-be-ready-at-neighbor (vector-ref (vector-ref dist nr) nc))
                        (vector-set! (vector-ref dist nr) nc time-to-be-ready-at-neighbor)
                        (heap-add! pq (list time-to-be-ready-at-neighbor nr nc))))
                  (loop)))

              (define final-time (vector-ref (vector-ref dist (- m 1)) (- n 1)))
              (if (= final-time +inf.0)
                  -1
                  final-time))))))