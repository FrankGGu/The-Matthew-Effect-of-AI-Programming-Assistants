(define (plates-between-candles s queries)
  (define n (string-length s))
  (define left (make-vector n 0))
  (define right (make-vector n 0))
  (define prefix-sum (make-vector n 0))

  (let loop ([i 0] [last-candle -1])
    (cond
      [(>= i n) (void)]
      [else
       (if (char=? (string-ref s i) #\|)
           (begin
             (vector-set! left i i)
             (set! last-candle i))
           (vector-set! left i last-candle))
       (loop (+ i 1) last-candle)]))

  (let loop ([i (- n 1)] [last-candle -1])
    (cond
      [(< i 0) (void)]
      [else
       (if (char=? (string-ref s i) #\|)
           (begin
             (vector-set! right i i)
             (set! last-candle i))
           (vector-set! right i last-candle))
       (loop (- i 1) last-candle)]))

  (let loop ([i 0] [count 0])
    (cond
      [(>= i n) (void)]
      [else
       (if (char=? (string-ref s i) #\*)
           (set! count (+ count 1))
           (void))
       (vector-set! prefix-sum i count)
       (loop (+ i 1) count)]))

  (map (lambda (query)
         (let ([start (car query)] [end (cadr query)])
           (let ([left-candle (vector-ref right start)]
                 [right-candle (vector-ref left end)])
             (if (and (>= right-candle 0) (>= left-candle 0) (< left-candle right-candle))
                 (- (vector-ref prefix-sum right-candle) (vector-ref prefix-sum left-candle))
                 0))))
       queries))