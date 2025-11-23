(define (longest-binary-subsequence-less-than-or-equal-to-k s k)
  (define (char-to-int c)
    (- (char->integer c) (char->integer #\0)))

  (define (solve s k current-length current-value index)
    (cond
      [(>= index (string-length s)) current-length]
      [else
       (let ([digit (char-to-int (string-ref s index))])
         (cond
           [(= digit 0)
            (solve s k (+ current-length 1) current-value (+ index 1))]
           [(<= (+ current-value (expt 2 (- (string-length s) index 1))) k)
            (max (solve s k current-length current-value (+ index 1))
                 (solve s k (+ current-length 1) (+ current-value (expt 2 (- (string-length s) index 1))) (+ index 1)))]
           [else
            (solve s k current-length current-value (+ index 1))]))]))

  (solve s k 0 0 0))