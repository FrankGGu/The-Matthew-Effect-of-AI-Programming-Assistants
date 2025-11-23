(define (is-symmetric? n)
  (cond
    [(< n 10) #f]
    [(< n 100)
     (= (quotient n 10) (remainder n 10))]
    [(< n 1000) #f]
    [(< n 10000)
     (let* ([d1 (quotient n 1000)]
            [rem1 (remainder n 1000)]
            [d2 (quotient rem1 100)]
            [rem2 (remainder rem1 100)]
            [d3 (quotient rem2 10)]
            [d4 (remainder rem2 10)])
       (= (+ d1 d2) (+ d3 d4)))]
    [else #f]))

(define (count-symmetric-integers low high)
  (let loop ([i low] [count 0])
    (if (> i high)
        count
        (loop (+ i 1) (if (is-symmetric? i) (+ count 1) count)))))