(define (maximum-sum nums)
  (define (sum-digits n)
    (let loop ([n n] [sum 0])
      (if (zero? n)
          sum
          (loop (quotient n 10) (+ sum (remainder n 10))))))

  (let ([sum-map (make-hash)])
    (for ([num nums])
      (let* ([s (sum-digits num)]
             [current (hash-ref sum-map s -1)])
        (if (= current -1)
            (hash-set! sum-map s num)
            (hash-set! sum-map s (max num current)))))

    (let ([max-sum -1])
      (hash-for-each sum-map
                     (lambda (s num)
                       (let ([current (hash-ref sum-map s -1)])
                         (when (not (= current num))
                           (set! max-sum (max max-sum (+ num current))))))
      max-sum)))