(define (my-atoi s)
  (let* ([trimmed-s (string-trim s)]
         [n (string-length trimmed-s)])
    (if (zero? n)
        0
        (let* ([sign (cond
                        [(equal? (string-ref trimmed-s 0) #\-) -1]
                        [(equal? (string-ref trimmed-s 0) #\+) 1]
                        [else 1])]
               [start-index (if (or (equal? (string-ref trimmed-s 0) #\-)
                                    (equal? (string-ref trimmed-s 0) #\+))
                                1
                                0)]
               [result 0])
          (let loop ([i start-index])
            (cond
              [(>= i n) result]
              [(char-numeric? (string-ref trimmed-s i))
               (let* ([digit (- (char->integer (string-ref trimmed-s i)) (char->integer #\0))]
                      [new-result (+ (* result 10) digit)])
                 (cond
                   [(and (> sign 0) (> new-result (sub1 (expt 2 31)))) (sub1 (expt 2 31))]
                   [(and (< sign 0) (> (- new-result) (expt 2 31))) (expt 2 31)]
                   [else (loop (add1 i))]
                   ))]
              [else result]))
          (* sign result)))))