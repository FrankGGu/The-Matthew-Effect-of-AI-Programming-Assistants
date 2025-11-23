#lang racket

(define (tiling-rectangle n m)
  (when (> n m)
    (define temp n)
    (set! n m)
    (set! m temp))

  (define memo (make-hash))
  (define global-min (box +inf.0))

  (define (solve board current-squares)
    (define cached-result (hash-ref memo board #f))
    (when cached-result
      cached-result)

    (when (>= current-squares (unbox global-min))
      +inf.0)

    (define first-empty-cell
      (let loop-rows ([i 0])
        (if (>= i n)
            #f
            (let loop-cols ([j 0])
              (if (>= j m)
                  (loop-rows (+ i 1))
                  (if (zero? (bitwise-and (vector-ref board i) (arithmetic-shift 1 j)))
                      (list i j)
                      (loop-cols (+ j 1))))))))

    (when (not first-empty-cell)
      (set-box! global-min (min (unbox global-min) current-squares))
      (hash-set! memo board current-squares)
      current-squares)

    (define r (first first-empty-cell))
    (define c (second first-empty-cell))

    (define min-res +inf.0)

    (for ([s (in-range (min (- n r) (- m c)) 0 -1)])
      (define can-place? #t)
      (let loop-check-rows ([i 0])
        (when (and can-place? (< i s))
          (let loop-check-cols ([j 0])
            (when (and can-place? (< j s))
              (when (not (zero? (bitwise-and (vector-ref board (+ r i)) (arithmetic-shift 1 (+ c j)))))
                (set! can-place? #f))
              (loop-check-cols (+ j 1))))
          (loop-check-rows (+ i 1))))

      (when can-place?
        (define new-board (vector-copy board))
        (for ([i (in-range s)])
          (define row-idx (+ r i))
          (define current-row-mask (vector-ref new-board row-idx))
          (define square-mask-for-row 0)
          (for ([j (in-range s)])
            (set! square-mask-for-row (bitwise-ior square-mask-for-row (arithmetic-shift 1 (+ c j)))))
          (vector-set! new-board row-idx (bitwise-ior current-row-mask square-mask-for-row)))

        (set! min-res (min min-res (solve new-board (+ current-squares 1))))))

    (hash-set! memo board min-res)
    min-res)

  (define initial-board (make-vector n 0))
  (solve initial-board 0))