(define (search-range nums target)
  (let* ((n (length nums))
         (vec (list->vector nums)))

    (define (find-first-occurrence)
      (let loop ((low 0) (high (- n 1)) (ans -1))
        (if (> low high)
            ans
            (let* ((mid (quotient (+ low high) 2))
                   (mid-val (vector-ref vec mid)))
              (cond
                ((= mid-val target)
                 (loop low (- mid 1) mid))
                ((< mid-val target)
                 (loop (+ mid 1) high ans))
                (else
                 (loop low (- mid 1) ans)))))))

    (define (find-last-occurrence)
      (let loop ((low 0) (high (- n 1)) (ans -1))
        (if (> low high)
            ans
            (let* ((mid (quotient (+ low high) 2))
                   (mid-val (vector-ref vec mid)))
              (cond
                ((= mid-val target)
                 (loop (+ mid 1) high mid))
                ((< mid-val target)
                 (loop (+ mid 1) high ans))
                (else
                 (loop low (- mid 1) ans)))))))

    (list (find-first-occurrence) (find-last-occurrence))))