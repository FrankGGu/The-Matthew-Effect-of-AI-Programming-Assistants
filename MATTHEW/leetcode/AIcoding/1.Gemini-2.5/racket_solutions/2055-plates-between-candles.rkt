(define (plates-between-candles s queries)
  (define n (string-length s))

  (define num-plates (make-vector (+ n 1) 0))
  (for ([i (in-range n)])
    (vector-set! num-plates (+ i 1)
                 (+ (vector-ref num-plates i)
                    (if (char=? (string-ref s i) #\*) 1 0))))

  (define next-candle (make-vector n -1))
  (let loop ([i (- n 1)]
             [last-candle-idx -1])
    (when (>= i 0)
      (if (char=? (string-ref s i) #\|)
          (begin
            (vector-set! next-candle i i)
            (loop (- i 1) i))
          (begin
            (vector-set! next-candle i last-candle-idx)
            (loop (- i 1) last-candle-idx)))))

  (define prev-candle (make-vector n -1))
  (let loop ([i 0]
             [last-candle-idx -1])
    (when (< i n)
      (if (char=? (string-ref s i) #\|)
          (begin
            (vector-set! prev-candle i i)
            (loop (+ i 1) i))
          (begin
            (vector-set! prev-candle i last-candle-idx)
            (loop (+ i 1) last-candle-idx)))))

  (for/list ([query queries])
    (define left (car query))
    (define right (cadr query))

    (define first-candle-idx (vector-ref next-candle left))
    (define last-candle-idx (vector-ref prev-candle right))

    (if (or (= first-candle-idx -1)
            (= last-candle-idx -1)
            (>= first-candle-idx last-candle-idx))
        0
        (- (vector-ref num-plates last-candle-idx)
           (vector-ref num-plates (+ first-candle-idx 1))))))