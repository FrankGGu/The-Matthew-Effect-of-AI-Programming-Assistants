(define (countPoints rings)
  (define rods (make-vector 10 0))
  (for ([i (in-range (string-length rings))])
    (when (= (modulo i 2) 0)
      (define color (string-ref rings i))
      (define rod (char->integer (string-ref rings (+ i 1))) - (char->integer #\0)))
      (cond
        [(= color #\R) (vector-set! rods rod (logior (vector-ref rods rod) 1))]
        [(= color #\G) (vector-set! rods rod (logior (vector-ref rods rod) 2))]
        [(= color #\B) (vector-set! rods rod (logior (vector-ref rods rod) 4))]))))
  (define count 0)
  (for ([i (in-range 10)])
    (when (= (vector-ref rods i) 7)
      (set! count (+ count 1))))
  count)