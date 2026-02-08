(define (sort-array-by-parity-ii nums)
  (let* ([n (vector-length nums)]
         [result (make-vector n)])
    (let loop ([i 0]
               [even-ptr 0]
               [odd-ptr 1])
      (when (< i n)
        (let ([val (vector-ref nums i)])
          (if (even? val)
              (begin
                (vector-set! result even-ptr val)
                (loop (+ i 1) (+ even-ptr 2) odd-ptr))
              (begin
                (vector-set! result odd-ptr val)
                (loop (+ i 1) even-ptr (+ odd-ptr 2)))))))
    result))