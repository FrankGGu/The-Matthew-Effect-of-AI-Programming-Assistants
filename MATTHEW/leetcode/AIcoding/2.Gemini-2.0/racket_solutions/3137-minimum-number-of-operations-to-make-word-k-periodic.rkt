(define (k-periodic s k)
  (let ((n (string-length s)))
    (if (zero? (remainder n k))
        (let loop ((i 0) (ops 0))
          (if (= i k)
              ops
              (let ((c (string-ref s i)))
                (let loop2 ((j i) (count 0))
                  (if (>= j n)
                      (+ ops (- (/ n k) count))
                      (if (equal? c (string-ref s j))
                          (loop2 (+ j k) (+ count 1))
                          (loop2 (+ j k) count)))))))
        #f))) ; Not a valid input according to the question

(provide k-periodic)