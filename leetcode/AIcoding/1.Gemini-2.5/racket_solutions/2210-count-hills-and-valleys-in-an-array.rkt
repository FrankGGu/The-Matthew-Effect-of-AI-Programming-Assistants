(define (count-hills-and-valleys nums)
  (let ((compress-list
         (lambda (lst)
           (if (empty? lst)
               '()
               (reverse
                (for/fold ((acc (list (car lst)))
                           (prev (car lst)))
                          ((val (cdr lst)))
                  (if (= val prev)
                      (values acc prev)
                      (values (cons val acc) val))))))))

    (let ((compressed (compress-list nums)))
      (let ((n (length compressed)))
        (if (< n 3)
            0
            (let loop ((i 1) (count 0))
              (if (>= i (- n 1))
                  count
                  (let* ((prev-val (list-ref compressed (- i 1)))
                         (curr-val (list-ref compressed i))
                         (next-val (list-ref compressed (+ i 1))))
                    (if (or (and (< prev-val curr-val) (> curr-val next-val))
                            (and (> prev-val curr-val) (< curr-val next-val)))
                        (loop (+ i 1) (+ count 1))
                        (loop (+ i 1) count)))))))))))