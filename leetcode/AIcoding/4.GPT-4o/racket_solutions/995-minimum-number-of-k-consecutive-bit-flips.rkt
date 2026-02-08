(define (minKBitFlips A K)
  (define n (length A))
  (define flips 0)
  (define flip-state (make-vector n #f))

  (define (flip i)
    (if (< i n)
        (begin
          (vector-set! flip-state i (not (vector-ref flip-state i)))
          (if (and (= (vector-ref A i) (if (vector-ref flip-state i) 0 1))
                   (= (vector-ref A i) 0))
              (begin
                (vector-set! A i 1)
                (set! flips (+ flips 1)))))
    )

  (let loop ((i 0))
    (if (< i n)
        (begin
          (flip i)
          (loop (+ i 1)))
      flips))

  (define count 0)
  (define result 0)
  (let loop2 ((i 0))
    (if (< i n)
        (begin
          (if (vector-ref flip-state i)
              (set! count (+ count 1))
              (set! count 0))
          (if (>= count K)
              (begin
                (set! result (+ result 1))
                (set! count (- count K))))
          (loop2 (+ i 1)))
      result)))

(minKBitFlips (vector 0 1 0) 1)