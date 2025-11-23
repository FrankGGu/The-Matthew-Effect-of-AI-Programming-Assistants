(define (largest-island grid)
  (define n (vector-length grid))
  (define (valid? r c)
    (and (>= r 0) (< r n) (>= c 0) (< c n)))
  (define (dfs r c color)
    (cond
      [(not (valid? r c)) 0]
      [(not (= (vector-ref (vector-ref grid r) c) 1)) 0]
      [else (begin
              (vector-set! (vector-ref grid r) c color)
              (+ 1
                 (dfs (+ r 1) c color)
                 (dfs (- r 1) c color)
                 (dfs r (+ c 1) color)
                 (dfs r (- c 1) color)))]))
  (define colors (make-hash))
  (define color 2)
  (define ans 0)
  (for ([i (in-range n)]
        [j (in-range n)])
    (when (= (vector-ref (vector-ref grid i) j) 1)
      (let ([size (dfs i j color)])
        (hash-set! colors color size)
        (set! ans (max ans size))
        (set! color (+ color 1)))))
  (for ([i (in-range n)]
        [j (in-range n)])
    (when (= (vector-ref (vector-ref grid i) j) 0)
      (define seen (make-hash))
      (define size 1)
      (define neighbors (list (cons (+ i 1) j) (cons (- i 1) j) (cons i (+ j 1)) (cons i (- j 1))))
      (for ([neighbor neighbors])
        (let ([r (car neighbor)]
              [c (cdr neighbor)])
          (when (and (valid? r c) (> (vector-ref (vector-ref grid r) c) 1))
            (let ([color (vector-ref (vector-ref grid r) c)])
              (unless (hash-has-key? seen color)
                (hash-set! seen color #t)
                (set! size (+ size (hash-ref colors color))))))))
      (set! ans (max ans size))))
  ans)