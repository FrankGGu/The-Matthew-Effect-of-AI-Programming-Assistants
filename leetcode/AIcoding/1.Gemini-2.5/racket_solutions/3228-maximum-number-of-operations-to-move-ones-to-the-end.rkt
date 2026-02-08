(define (max-operations s)
  (let* ([n (string-length s)]
         [total-operations 0]
         [current-streak-of-ones 0])
    (for ([i (in-range n)])
      (let ([char (string-ref s i)])
        (cond
          [(char=? char #\1)
           (set! current-streak-of-ones (+ current-streak-of-ones 1))]
          [(char=? char #\0)
           (when (> current-streak-of-ones 1)
             (set! total-operations
                   (+ total-operations
                      (/ (* (- current-streak-of-ones 1) current-streak-of-ones) 2))))
           (set! current-streak-of-ones 0)])))
    (when (> current-streak-of-ones 1)
      (set! total-operations
            (+ total-operations
               (/ (* (- current-streak-of-ones 1) current-streak-of-ones) 2))))
    total-operations))