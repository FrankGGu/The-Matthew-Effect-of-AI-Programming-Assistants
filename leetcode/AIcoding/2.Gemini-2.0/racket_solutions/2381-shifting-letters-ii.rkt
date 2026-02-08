(define (shifting-letters s shifts)
  (define n (string-length s))
  (define diff (make-vector (add1 n) 0))

  (for ([shift shifts])
    (let ([start (first shift)]
          [end (second shift)]
          [direction (third shift)])
      (vector-set! diff start (if (= direction 1) (+ (vector-ref diff start) 1) (+ (vector-ref diff start) -1)))
      (if (< (add1 end) n)
          (vector-set! diff (add1 end) (if (= direction 1) (+ (vector-ref diff (add1 end)) -1) (+ (vector-ref diff (add1 end)) 1))))))

  (define prefix (make-vector n 0))
  (vector-set! prefix 0 (vector-ref diff 0))
  (for ([i (in-range 1 n)])
    (vector-set! prefix i (+ (vector-ref prefix (sub1 i)) (vector-ref diff i))))

  (define result (list->string
                   (map (lambda (i)
                          (integer->char
                           (+ (modulo (+ (char->integer (string-ref s i)) (vector-ref prefix i)) 26)
                              (char->integer #\a))))
                        (range n))))
  result)