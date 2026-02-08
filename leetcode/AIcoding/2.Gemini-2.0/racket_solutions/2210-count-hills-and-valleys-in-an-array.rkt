(define (count-hills-and-valleys nums)
  (let* ((n (length nums))
         (peaks-valleys (cond
                           ((<= n 2) 0)
                           (else
                            (let loop ((i 1) (prev (list (list 0 (list-ref nums 0)))) (count 0))
                              (if (= i n)
                                  count
                                  (let* ((curr-num (list-ref nums i))
                                         (last-num (car (car prev)))
                                         (last-val (car (cdr (car prev)))))
                                    (if (= curr-num last-val)
                                        (loop (+ i 1) prev count)
                                        (let* ((new-prev (cons (list i curr-num) prev))
                                               (is-peak-valley
                                                (cond
                                                  ((>= (length new-prev) 3)
                                                   (let* ((first-index (car (car new-prev)))
                                                          (first-value (car (cdr (car new-prev))))
                                                          (second-index (car (car (cdr new-prev))))
                                                          (second-value (car (cdr (car (cdr new-prev)))))
                                                          (third-index (car (car (cdr (cdr new-prev)))))
                                                          (third-value (car (cdr (car (cdr (cdr new-prev)))))))
                                                     (cond
                                                       ((and (> second-value first-value) (> second-value third-value)) #t)
                                                       ((and (< second-value first-value) (< second-value third-value)) #t)
                                                       (else #f))))
                                                  (else #f))))
                                          (loop (+ i 1) new-prev (if is-peak-valley (+ count 1) count))))))))))))
    peaks-valleys))