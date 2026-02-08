(define (max-students seats)
  (define m (length seats))
  (define n (length (car seats)))

  (define (is-valid? row mask)
    (let loop ((i 0))
      (if (= i n)
          #t
          (if (zero? (bitwise-and mask (arithmetic-shift 1 i)))
              (loop (+ i 1))
              (and (zero? (bitwise-and mask (arithmetic-shift 1 (max 0 (- i 1)))))
                   (zero? (bitwise-and mask (arithmetic-shift 1 (min (- n 1) (+ i 1)))))
                   (loop (+ i 1)))))))

  (define (count-bits mask)
    (let loop ((mask mask) (count 0))
      (if (zero? mask)
          count
          (loop (bitwise-and mask (- mask 1)) (+ count 1)))))

  (define valid-masks
    (filter (lambda (mask) (is-valid? (list #f) mask))
            (range (expt 2 n))))

  (define (solve row prev-mask)
    (if (= row m)
        0
        (let ((max-count 0))
          (for-each
           (lambda (mask)
             (if (is-valid? (list #f) mask)
                 (let ((row-seats (list-ref seats row))
                       (valid-mask (let loop ((i 0) (new-mask 0))
                                      (if (= i n)
                                          new-mask
                                          (if (equal? (list-ref row-seats i) #\#)
                                              (loop (+ i 1) (bitwise-ior new-mask (arithmetic-shift 1 i)))
                                              (loop (+ i 1) new-mask)))))))

                   (if (= (bitwise-and mask valid-mask) mask)
                       (let ((safe-mask (lambda (i) (zero? (bitwise-and mask (arithmetic-shift 1 i)))))
                             (safe-prev-mask (lambda (i) (zero? (bitwise-and prev-mask (arithmetic-shift 1 i))))))
                         (let loop ((i 0) (valid #t))
                           (if (= i n)
                               (if valid
                                   (set! max-count (max max-count (+ (count-bits mask) (solve (+ row 1) mask))))
                                   #f)
                               (if (safe-mask i)
                                   (loop (+ i 1) valid)
                                   (if (and (or (and (> i 0) (safe-prev-mask (- i 1))) #f)
                                            (or (and (< i (- n 1)) (safe-prev-mask (+ i 1))) #f))
                                       (loop (+ i 1) valid)
                                       (loop (+ i 1) #f))))))))))
           valid-masks)
          max-count)))

  (solve 0 0))