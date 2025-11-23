(define (remove-boxes boxes-list)
  (define boxes (list->vector boxes-list))
  (define n (vector-length boxes))

  (if (= n 0)
      0
      (begin
        (define memo (make-hash))

        (define (dp i j k)
          (cond
            ((> i j) 0)
            (else
             (let ((key (list i j k)))
               (hash-ref! memo key
                          (lambda ()
                            (let* ((current-box (vector-ref boxes j))
                                   (res (+ (* (+ k 1) (+ k 1)) (dp i (- j 1) 0))))

                              (for-each
                               (lambda (m)
                                 (when (= (vector-ref boxes m) current-box)
                                   (set! res (max res (+ (dp i m (+ k 1)) (dp (+ m 1) (- j 1) 0))))))
                               (build-list (- j i) (lambda (x) (+ i x))))
                              res)))))))

        (dp 0 (- n 1) 0))))