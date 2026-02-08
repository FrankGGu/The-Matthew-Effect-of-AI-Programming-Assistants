#lang racket

(require data/queue)

(define (max-distance grid)
  (define N (length grid))
  (define q (make-queue))
  (define distances (make-vector N))
  (define num-land-cells 0)

  (for ([r (in-range N)])
    (define row-distances (make-vector N))
    (for ([c (in-range N)])
      (if (= (list-ref (list-ref grid r) c) 1)
          (begin
            (queue-put! q (list r c))
            (vector-set! row-distances c 0)
            (set! num-land-cells (+ num-land-cells 1)))
          (vector-set! row-distances c -1)))
    (vector-set! distances r row-distances))

  (define max-dist -1)

  (define dr (list -1 1 0 0))
  (define dc (list 0 0 -1 1))

  (while (not (queue-empty? q))
    (define-values (r c) (apply values (queue-get! q)))
    (define current-dist (vector-ref (vector-ref distances r) c))

    (for ([i (in-range 4)])
      (define nr (+ r (list-ref dr i)))
      (define nc (+ c (list-ref dc i)))

      (when (and (>= nr 0) (< nr N)
                 (>= nc 0) (< nc N)
                 (= (vector-ref (vector-ref distances nr) nc) -1))
        (vector-set! (vector-ref distances nr) nc (+ current-dist 1))
        (queue-put! q (list nr nc))
        (set! max-dist (max max-dist (+ current-dist 1))))))

  max-dist)