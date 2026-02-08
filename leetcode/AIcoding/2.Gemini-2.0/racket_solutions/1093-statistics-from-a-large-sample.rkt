(define (sample-stats counts)
  (let* ((n (apply + counts))
         (min (let loop ((i 0))
                 (if (> (list-ref counts i) 0)
                     i
                     (loop (+ i 1)))))
         (max (let loop ((i (- (length counts) 1)))
                 (if (> (list-ref counts i) 0)
                     i
                     (loop (- i 1)))))
         (sum (for/sum ((i (in-range (length counts))))
                (* i (list-ref counts i))))
         (mean (/ sum n))
         (median
          (let loop ((i 0) (count 0))
            (cond
              ((>= (+ count (list-ref counts i)) (/ n 2))
               (if (odd? n)
                   i
                   (let ((next-index (+ i 1)))
                     (cond
                       ((>= (+ count (list-ref counts i)) (/ n 2) 0.5) i)
                       ((< next-index (length counts))
                        (if (> (list-ref counts next-index) 0)
                            (/ (+ i next-index) 2.0)
                            i))
                       (else i)))))
              (else
               (loop (+ i 1) (+ count (list-ref counts i)))))))
         (mode (let loop ((i 0) (max-count 0) (mode 0))
                 (cond
                   ((= i (length counts)) mode)
                   ((> (list-ref counts i) max-count)
                    (loop (+ i 1) (list-ref counts i) i))
                   (else
                    (loop (+ i 1) max-count mode))))))
    (list (real->double min) (real->double max) (real->double mean) (real->double median) (real->double mode))))