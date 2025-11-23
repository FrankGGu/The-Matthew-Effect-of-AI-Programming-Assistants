(define (arithmetic-slices nums)
  (let* ([n (vector-length nums)]
         [total-slices 0]
         [current-slices 0])
    (if (< n 3)
        0
        (begin
          (for ([i (in-range 2 n)])
            (if (= (- (vector-ref nums i) (vector-ref nums (- i 1)))
                   (- (vector-ref nums (- i 1)) (vector-ref nums (- i 2))))
                (set! current-slices (+ current-slices 1))
                (set! current-slices 0))
            (set! total-slices (+ total-slices current-slices)))
          total-slices))))