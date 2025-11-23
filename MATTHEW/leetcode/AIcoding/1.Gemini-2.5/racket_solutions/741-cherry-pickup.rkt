(define (cherry-pickup grid)
  (define N (vector-length grid))
  (define memo (make-hash))

  (define (dp t r1 r2)
    (define c1 (- t r1))
    (define c2 (- t r2))

    (when (or (< r1 0) (>= r1 N) (< c1 0) (>= c1 N)
              (< r2 0) (>= r2 N) (< c2 0) (>= c2 N)
              (= (vector-ref (vector-ref grid r1) c1) -1)
              (= (vector-ref (vector-ref grid r2) c2) -1))
      (hash-set! memo (list t r1 r2) -1)
      -1)

    (define memo-key (list t r1 r2))
    (define cached-val (hash-ref memo memo-key #f))
    (when cached-val
      cached-val)

    (when (= t 0)
      (define val (vector-ref (vector-ref grid 0) 0))
      (hash-set! memo memo-key val)
      val)

    (define max-prev-cherries -1)

    (for* ([prev-r1-offset '(0 1)]
           [prev-r2-offset '(0 1)])
      (define prev-r1 (- r1 prev-r1-offset))
      (define prev-r2 (- r2 prev-r2-offset))

      (define val (dp (- t 1) prev-r1 prev-r2))
      (when (>= val 0)
        (set! max-prev-cherries (max max-prev-cherries val))))

    (when (= max-prev-cherries -1)
      (hash-set! memo memo-key -1)
      -1)

    (define current-cherries (vector-ref (vector-ref grid r1) c1))
    (when (not (and (= r1 r2) (= c1 c2)))
      (set! current-cherries (+ current-cherries (vector-ref (vector-ref grid r2) c2))))

    (define total-cherries (+ max-prev-cherries current-cherries))
    (hash-set! memo memo-key total-cherries)
    total-cherries)

  (if (= (vector-ref (vector-ref grid 0) 0) -1)
      0
      (let ((result (dp (* 2 (- N 1)) (- N 1) (- N 1))))
        (if (< result 0) 0 result))))