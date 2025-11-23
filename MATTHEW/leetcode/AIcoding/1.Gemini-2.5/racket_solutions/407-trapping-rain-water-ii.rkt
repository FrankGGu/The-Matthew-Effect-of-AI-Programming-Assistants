#lang racket
(require data/heap)
(require racket/vector)

(define (trap-rain-water-ii height-map)
  (define m (vector-length height-map))
  (when (zero? m) (error 'trap-rain-water-ii "empty height map"))
  (define n (vector-length (vector-ref height-map 0)))
  (when (zero? n) (error 'trap-rain-water-ii "empty height map row"))

  (define visited (build-vector m (lambda (r) (make-vector n #f))))

  (define (heap-compare a b)
    (< (car a) (car b)))

  (define pq (make-heap heap-compare))

  (for ([r (in-range m)])
    (for ([c (in-range n)])
      (when (or (= r 0) (= r (- m 1)) (= c 0) (= c (- n 1)))
        (heap-add! pq (list (vector-ref (vector-ref height-map r) c) r c))
        (vector-set! (vector-ref visited r) c #t))))

  (define total-water 0)

  (define dr '(-1 1 0 0))
  (define dc '(0 0 -1 1))

  (let loop ()
    (when (not (heap-empty? pq))
      (define current-cell (heap-extract-min! pq))
      (define h (car current-cell))
      (define r (cadr current-cell))
      (define c (caddr current-cell))

      (for ([i (in-range 4)])
        (define nr (+ r (list-ref dr i)))
        (define nc (+ c (list-ref dc i)))

        (when (and (>= nr 0) (< nr m) (>= nc 0) (< nc n)
                   (not (vector-ref (vector-ref visited nr) nc)))
          (vector-set! (vector-ref visited nr) nc #t)
          (define neighbor-height (vector-ref (vector-ref height-map nr) nc))

          (set! total-water (+ total-water (max 0 (- h neighbor-height))))

          (heap-add! pq (list (max h neighbor-height) nr nc))))
      (loop)))
  total-water)