(define (smooth-descent-periods prices)
  (if (null? prices)
      0
      (let loop ((rest (cdr prices))
                 (prev (car prices))
                 (current-length 1)
                 (total-periods 1))
        (if (null? rest)
            total-periods
            (let* ((current (car rest))
                   (new-current-length (if (= (- current prev) -1)
                                           (+ current-length 1)
                                           1)))
              (loop (cdr rest)
                    current
                    new-current-length
                    (+ total-periods new-current-length)))))))