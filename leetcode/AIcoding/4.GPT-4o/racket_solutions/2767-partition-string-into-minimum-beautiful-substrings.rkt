(define (minimum-beautiful-substrings s)
  (define (is-beautiful substring)
    (and (string? substring) 
         (or (string=? substring "0") 
             (string=? substring "1")
             (string-prefix? substring "10")
             (string-prefix? substring "110"))))

  (define (dfs start count)
    (if (= start (string-length s))
        count
        (define max-count (inexact->exact (floor (/ (- (string-length s) start) 2))))
        (define result (for/fold ([min-count +inf.0]) ([i (in-range start (+ start max-count))])
                        (if (is-beautiful (substring s start (add1 i)))
                            (min min-count (dfs (add1 i) (add1 count)))
                            min-count)))
        (if (= result +inf.0)
            -1
            result)))

  (dfs 0 0))

(minimum-beautiful-substrings "011101") ; Example input