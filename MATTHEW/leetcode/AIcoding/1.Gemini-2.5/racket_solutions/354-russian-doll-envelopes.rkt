(define (russian-doll-envelopes envelopes)
  (define sorted-envelopes
    (sort envelopes
          (lambda (e1 e2)
            (let ((w1 (car e1))
                  (h1 (cdr e1))
                  (w2 (car e2))
                  (h2 (cdr e2)))
              (if (= w1 w2)
                  (> h1 h2) ; Sort by decreasing height if widths are equal
                  (< w1 w2)))))) ; Sort by increasing width

  (define heights (map cdr sorted-envelopes))

  (define (lis-length heights)
    (if (null? heights)
        0
        (let* ((n (length heights))
               (tails (make-vector n 0))) ; Pre-allocate vector for LIS tails
          (let loop ((h-list heights) (len 0))
            (if (null? h-list)
                len
                (let* ((h (car h-list))
                       (idx (let binary-search-insert ((low 0) (high (- len 1)) (ans len))
                              ; Finds the smallest index i such that tails[i] >= h
                              ; If h is greater than all elements, returns len
                              (if (> low high)
                                  ans
                                  (let ((mid (quotient (+ low high) 2)))
                                    (if (>= (vector-ref tails mid) h)
                                        (binary-search-insert low (- mid 1) mid)
                                        (binary-search-insert (+ mid 1) high ans)))))))
                  (vector-set! tails idx h)
                  (loop (cdr h-list) (if (= idx len) (+ len 1) len))))))))

  (lis-length heights))