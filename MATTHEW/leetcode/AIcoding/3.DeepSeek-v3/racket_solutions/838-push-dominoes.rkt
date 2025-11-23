(define/contract (push-dominoes dominoes)
  (-> string? string?)
  (define n (string-length dominoes))
  (define forces (make-vector n 0))
  (define force 0)

  ; Left to right
  (for ([i (in-range n)])
    (define c (string-ref dominoes i))
    (cond [(char=? c #\R) (set! force n)]
          [(char=? c #\L) (set! force 0)]
          [else (set! force (max (- force 1) 0))])
    (vector-set! forces i (+ (vector-ref forces i) force)))

  (set! force 0)

  ; Right to left
  (for ([i (in-range (- n 1) -1 -1)])
    (define c (string-ref dominoes i))
    (cond [(char=? c #\L) (set! force n)]
          [(char=? c #\R) (set! force 0)]
          [else (set! force (max (- force 1) 0))])
    (vector-set! forces i (- (vector-ref forces i) force)))

  (define result (make-string n))
  (for ([i (in-range n)])
    (define f (vector-ref forces i))
    (string-set! result i 
                 (cond [(> f 0) #\R]
                       [(< f 0) #\L]
                       [else #\.])))
  result)