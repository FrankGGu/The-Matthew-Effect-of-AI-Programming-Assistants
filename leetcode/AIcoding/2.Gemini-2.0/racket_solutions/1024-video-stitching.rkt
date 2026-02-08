(define (video-stitching clips time)
  (let* ([n (length clips)]
         [max-reach (make-vector (add1 time) 0)])
    (for ([clip clips])
      (let ([start (car clip)]
            [end (cadr clip)])
        (when (<= start time)
          (vector-set! max-reach start (min time (max (vector-ref max-reach start) end))))))
    (let loop ([curr-reach 0]
               [next-reach 0]
               [count 0])
      (cond
        [(>= curr-reach time) count]
        [(< curr-reach next-reach) -1]
        [else
         (let loop2 ([i 0])
           (cond
             [(> i curr-reach) (loop curr-reach next-reach (add1 count))]
             [else
              (loop2 (add1 i))
              (set! next-reach (max next-reach (vector-ref max-reach i))))))])))