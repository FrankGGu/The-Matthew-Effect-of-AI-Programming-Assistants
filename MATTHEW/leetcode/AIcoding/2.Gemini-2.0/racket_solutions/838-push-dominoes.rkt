(define (push-dominoes dominoes)
  (define n (string-length dominoes))
  (define forces (make-vector n 0))

  (define (calculate-forces)
    (let loop ([i 0] [force 0])
      (cond
        [(>= i n) #t]
        [else
         (cond
           [(char=? (string-ref dominoes i) #\R)
            (set! force n)]
           [(char=? (string-ref dominoes i) #\L)
            (set! force 0)]
           [else
            (set! force (max 0 (- force 1)))])
         (vector-set! forces i (+ (vector-ref forces i) force))
         (loop (+ i 1) force)]))

    (let loop ([i (- n 1)] [force 0])
      (cond
        [(< i 0) #t]
        [else
         (cond
           [(char=? (string-ref dominoes i) #\L)
            (set! force n)]
           [(char=? (string-ref dominoes i) #\R)
            (set! force 0)]
           [else
            (set! force (max 0 (- force 1)))])
         (vector-set! forces i (- (vector-ref forces i) force))
         (loop (- i 1) force)])))

  (calculate-forces)

  (define result (make-string n #\.))
  (for ([i (in-range n)])
    (cond
      [(> (vector-ref forces i) 0)
       (string-set! result i #\R)]
      [(< (vector-ref forces i) 0)
       (string-set! result i #\L)]
      [else
       (string-set! result i (string-ref dominoes i))]))

  result)