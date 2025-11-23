#lang racket

(define (number-of-possible-sets n max-distance roads)
  (define +inf.0 (expt 10 9))

  (define (get-bit mask i)
    (not (zero? (bitwise-and mask (arithmetic-shift 1 i)))))

  (define count 0)

  (for ([mask (in-range 0 (expt 2 n))])
    (define current-dist (make-vector n (lambda () (make-vector n +inf.0))))

    (for ([i (in-range n)])
      (vector-set! (vector-ref current-dist i) i 0))

    (for ([road roads])
      (define u (car road))
      (define v (cadr road))
      (define w (caddr road))
      (when (and (get-bit mask u) (get-bit mask v))
        (vector-set! (vector-ref current-dist u) v (min (vector-ref (vector-ref current-dist u) v) w))
        (vector-set! (vector-ref current-dist v) u (min (vector-ref (vector-ref current-dist v) u) w))))

    (for ([k (in-range n)])
      (when (get-bit mask k)
        (for ([i (in-range n)])
          (when (get-bit mask i)
            (for ([j (in-range n)])
              (when (get-bit mask j)
                (let ([dist-ik (vector-ref (vector-ref current-dist i) k)]
                      [dist-kj (vector-ref (vector-ref current-dist k) j)])
                  (when (and (< dist-ik +inf.0) (< dist-kj +inf.0))
                    (vector-set! (vector-ref current-dist i) j
                                 (min (vector-ref (vector-ref current-dist i) j)
                                      (+ dist-ik dist-kj))))))))))

    (define valid-subset? #t)
    (for ([i (in-range n)])
      (when (get-bit mask i)
        (for ([j (in-range (+ i 1) n)])
          (when (get-bit mask j)
            (when (> (vector-ref (vector-ref current-dist i) j) max-distance)
              (set! valid-subset? #f)
              (break))))
        (when (not valid-subset?)
          (break))))

    (when valid-subset?
      (set! count (+ count 1))))

  count)