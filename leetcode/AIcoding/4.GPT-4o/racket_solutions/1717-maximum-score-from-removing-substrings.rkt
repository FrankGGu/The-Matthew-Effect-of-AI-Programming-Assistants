(define (maximum-score s)
  (define (score-from substr)
    (if (string=? substr "")
        0
        (let loop ((s s) (total 0))
          (cond
            ((string-contains? s substr)
             (loop (string-replace s substr "") (+ total (string-length substr))))
            (else total)))))
  (let loop ((i 0) (max-score 0))
    (if (< i (string-length s))
        (loop (+ i 1) (max max-score (score-from (substring s i (add1 i)))))
        max-score)))

(maximum-score "cdbcbbaa") ; Example input