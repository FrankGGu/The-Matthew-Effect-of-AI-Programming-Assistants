(define (min-flips mono)
  (define n (string-length mono))
  (define prefix-ones (make-vector (+ n 1) 0))
  (define suffix-zeros (make-vector (+ n 1) 0))

  (for ([i (in-range n)])
    (vector-set! prefix-ones (+ i 1) (+ (vector-ref prefix-ones i) (if (char=? (string-ref mono i) #\1) 0 1))))

  (for ([i (in-range (- n 1) -1 -1)])
    (vector-set! suffix-zeros i (+ (vector-ref suffix-zeros (+ i 1)) (if (char=? (string-ref mono i) #\0) 0 1))))

  (define min-flips (for/fold ([min-inf +inf]) ([i (in-range (+ n 1))])
                      (min min-inf (+ (vector-ref prefix-ones i) (vector-ref suffix-zeros i)))))

  min-flips)