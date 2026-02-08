#lang racket

(define (minimum-operations-to-make-special-number num)
  (define n (string-length num))

  (define (solve-for-suffix target-X target-Y)
    (let ([idx-Y -1]
          [found-Y #f])
      (for ([j (in-range (- n 1) -1 -1)])
        (when (char=? (string-ref num j) target-Y)
          (set! idx-Y j)
          (set! found-Y #t)
          (break)))

      (unless found-Y
        (add1 n))

      (let ([idx-X -1]
            [found-X #f])
        (for ([i (in-range (- idx-Y 1) -1 -1)])
          (when (char=? (string-ref num i) target-X)
            (set! idx-X i)
            (set! found-X #t)
            (break)))

        (unless found-X
          (add1 n))

        (+ (- n 1 idx-Y) (- idx-Y 1 idx-X)))))

  (let ([min-ops n])
    (when (string-contains? num "0")
      (set! min-ops (- n 1)))

    (set! min-ops (min min-ops (solve-for-suffix #\0 #\0)))
    (set! min-ops (min min-ops (solve-for-suffix #\2 #\5)))
    (set! min-ops (min min-ops (solve-for-suffix #\5 #\0)))
    (set! min-ops (min min-ops (solve-for-suffix #\7 #\5)))

    min-ops))