(define (find-kth-character n k)
  (if (= n 1)
      "0"
      (let* ([len (expt 2 (- n 1))]
             [half-len (/ len 2)])
        (if (<= k half-len)
            (find-kth-character (- n 1) k)
            (let* ([prev-char (find-kth-character (- n 1) (- k half-len))])
              (if (equal? prev-char "0")
                  "1"
                  "0")))))))