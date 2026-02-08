#lang racket

(require racket/hash)
(require racket/queue)

(struct region (infected-cells potential-spread walls-needed) #:transparent)

(define (contain-virus grid)
  (define rows (vector-length grid))
  (define cols (vector-length (vector-ref grid 0)))
  (define total-walls 0)

  (define (in-bounds r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (let loop ()
    (define visited (build-vector rows (lambda (i) (make-vector cols #f))))
    (define infected-regions '())

    (for* ([r (in-range rows)]
           [c (in-range cols)])
      (when (and (= (vector-ref (vector-ref grid r) c) 1)
                 (not (vector-ref (vector-ref visited r) c)))
        (define current-region-infected-cells (hash-set))
        (define current-region-potential-spread (hash-set))
        (define current-region-walls-needed 0)

        (define q (make-queue))
        (queue-add q (list r c))
        (vector-set! (vector-ref visited r) c #t)

        (let bfs-loop ()
          (when (not (queue-empty? q))
            (define current-cell (queue-remove q))
            (define current-r (car current-cell))
            (define current-c (cadr current-cell))
            (set! current-region-infected-cells (hash-set-add current-region-infected-cells current-cell))

            (for ([i (in-range 4)])
              (define nr (+ current-r (list-ref '(-1 1 0 0) i)))
              (define nc (+ current-c (list-ref '(0 0 -1 1) i)))
              (when (in-bounds nr nc)
                (define neighbor-val (vector-ref (vector-ref grid nr) nc))
                (cond
                  [(= neighbor-val 1)
                   (when (not (vector-ref (vector-ref visited nr) nc))
                     (vector-set! (vector-ref visited nr) nc #t)
                     (queue-add q (list nr nc)))]
                  [(= neighbor-val 0)
                   (set! current-region-potential-spread (hash-set-add current-region-potential-spread (list nr nc)))
                   (set! current-region-walls-needed (+ current-region-walls-needed 1))]))
            )
            (bfs-loop)))

        (set! infected-regions (cons (region current-region-infected-cells
                                            current-region-potential-spread
                                            current-region-walls-needed)
                                     infected-regions))))

    (when (empty? infected-regions)
      (break loop))

    (define best-region #f)
    (define max-potential-spread-size -1)
    (for ([reg infected-regions])
      (define current-potential-spread-size (hash-set-count (region-potential-spread reg)))
      (when (> current-potential-spread-size max-potential-spread-size)
        (set! max-potential-spread-size current-potential-spread-size)
        (set! best-region reg)))

    (when (or (not best-region) (= max-potential-spread-size 0))
      (break loop))

    (set! total-walls (+ total-walls (region-walls-needed best-region)))

    (for ([cell (in-hash-set (region-infected-cells best-region))])
      (define r (car cell))
      (define c (cadr cell))
      (vector-set! (vector-ref grid r) c 2))

    (for ([reg infected-regions])
      (when (not (eq? reg best-region))
        (for ([cell (in-hash-set (region-potential-spread reg))])
          (define r (car cell))
          (define c (cadr cell))
          (when (= (vector-ref (vector-ref grid r) c) 0)
            (vector-set! (vector-ref grid r) c 1)))))

    (loop)))

  total-walls)