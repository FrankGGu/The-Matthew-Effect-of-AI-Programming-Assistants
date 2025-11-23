(define (maximum-triplet-value nums)
  (let* ([n (length nums)]
         [max-left (make-vector n 0)]
         [max-right (make-vector n 0)]
         [current-max 0])
    (for ([i (in-range 0 n)])
      (vector-set! max-left i current-max)
      (set! current-max (max current-max (vector-ref nums i))))
    (set! current-max 0)
    (for ([i (in-range (- n 1) -1 -1)])
      (vector-set! max-right i current-max)
      (set! current-max (max current-max (vector-ref nums i))))
    (let loop ([i 1]
               [max-value 0])
      (if (= i (- n 1))
          max-value
          (let ([val (* (- (vector-ref max-left i) (vector-ref nums i)) (vector-ref max-right i))])
            (loop (+ i 1) (max max-value val)))))))