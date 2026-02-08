(define (max-score sightseeings)
  (let ((n (length sightseeings)))
    (if (zero? n)
        0
        (let loop ((i 1) (max-so-far (first sightseeings) 0))
          (if (= i n)
              max-so-far
              (let ((current-score (+ (list-ref sightseeings i)
                                      (- (abs (- i 0))))))
                (loop (+ i 1) (max max-so-far (+ (first sightseeings) (- (abs (- i 0))))))))))))