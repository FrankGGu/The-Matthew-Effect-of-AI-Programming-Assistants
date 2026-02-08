(define (nthUglyNumber n)
  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 1 1)
  (define i2 1)
  (define i3 1)
  (define i5 1)
  (define next2 2)
  (define next3 3)
  (define next5 5)

  (do ((i 2 (+ i 1)))
      ((> i n) (vector-ref dp n)))
    (vector-set! dp i (min next2 next3 next5))
    (cond
      [(= (vector-ref dp i) next2)
       (set! i2 (+ i2 1))
       (set! next2 (* (vector-ref dp i2) 2))]
      [(= (vector-ref dp i) next3)
       (set! i3 (+ i3 1))
       (set! next3 (* (vector-ref dp i3) 3))]
      [(= (vector-ref dp i) next5)
       (set! i5 (+ i5 1))
       (set! next5 (* (vector-ref dp i5) 5)))])))