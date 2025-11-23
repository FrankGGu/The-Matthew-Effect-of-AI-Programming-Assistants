(define (is-possible nums)
  (let ((counts (make-hash))
        (ends (make-hash)))

    (for-each (lambda (num)
                (hash-set! counts num (+ (hash-ref counts num 0) 1)))
              nums)

    (let loop ((remaining-nums nums))
      (if (null? remaining-nums)
          #t
          (let* ((n (car remaining-nums))
                 (current-n-count (hash-ref counts n 0)))

            (if (= current-n-count 0)
                (loop (cdr remaining-nums))
                (cond
                  ((> (hash-ref ends (- n 1) 0) 0)
                   (hash-set! ends (- n 1) (- (hash-ref ends (- n 1) 0) 1))
                   (hash-set! ends n (+ (hash-ref ends n 0) 1))
                   (hash-set! counts n (- current-n-count 1))
                   (loop (cdr remaining-nums)))

                  ((and (> (hash-ref counts (+ n 1) 0) 0)
                        (> (hash-ref counts (+ n 2) 0) 0))
                   (hash-set! counts n (- current-n-count 1))
                   (hash-set! counts (+ n 1) (- (hash-ref counts (+ n 1) 0) 1))
                   (hash-set! counts (+ n 2) (- (hash-ref counts (+ n 2) 0) 1))
                   (hash-set! ends (+ n 2) (+ (hash-ref ends (+ n 2) 0) 1))
                   (loop (cdr remaining-nums)))

                  (else
                   #f))))))))