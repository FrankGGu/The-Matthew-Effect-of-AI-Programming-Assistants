(require racket/vector)
(require racket/queue)

(define (last-day-where-you-can-still-cross row col cells)

  (define (check num-days)
    (define is-water (make-vector row (lambda () (make-vector col #f))))
    (for ([i (in-range num-days)])
      (define cell (list-ref cells i))
      (define r (car cell))
      (define c (cdr cell))
      (vector-set! (vector-ref is-water r) c #t))

    (define visited (make-vector row (lambda () (make-vector col #f))))
    (define q (make-queue))

    (for ([c (in-range col)])
      (when (not (vector-ref (vector-ref is-water 0) c))
        (enqueue! q (list 0 c))
        (vector-set! (vector-ref visited 0) c #t)))

    (define dr (list -1 1 0 0))
    (define dc (list 0 0 -1 1))

    (let bfs-loop ()
      (if (queue-empty? q)
          #f
          (let* ([current-cell (dequeue! q)]
                 [r (car current-cell)]
                 [c (cdr current-cell)])

            (if (= r (- row 1))
                #t
                (begin
                  (for ([i (in-range 4)])
                    (define nr (+ r (list-ref dr i)))
                    (define nc (+ c (list-ref dc i)))

                    (when (and (>= nr 0) (< nr row)
                               (>= nc 0) (< nc col)
                               (not (vector-ref (vector-ref is-water nr) nc))
                               (not (vector-ref (vector-ref visited nr) nc)))
                      (vector-set! (vector-ref visited nr) nc #t)
                      (enqueue! q (list nr nc))))
                  (bfs-loop)))))))

  (define low 0)
  (define high (length cells))
  (define ans 0)

  (let binary-search-loop ()
    (when (<= low high)
      (define mid (quotient (+ low high) 2))
      (if (check mid)
          (begin
            (set! ans mid)
            (set! low (+ mid 1)))
          (set! high (- mid 1))))
    (if (<= low high) (binary-search-loop) ans)))