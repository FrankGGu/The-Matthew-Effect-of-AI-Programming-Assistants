(define (is-possible target)
  (let loop ([heap (make-heap >)] [sum 0])
    (for ([x target])
      (heap-add! heap x)
      (set! sum (+ sum x)))
    (if (equal? (heap-count heap) 1)
        (heap-top heap)
        (let ([largest (heap-top heap)])
          (if (= largest 1)
              #t
              (let ([rest-sum (- sum largest)])
                (if (<= rest-sum 0)
                    #f
                    (let ([prev (modulo largest rest-sum)])
                      (if (= prev 0)
                          #f
                          (begin
                            (heap-remove-top! heap)
                            (heap-add! heap prev)
                            (set! sum (+ rest-sum prev))
                            (loop heap sum)))))))))))