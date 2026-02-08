(define (decode-slanted-ciphertext encodedText rows)
  (let* ((N (string-length encodedText))
         (cols
          (if (zero? N)
              0 ; Special case for empty encodedText
              (let loop-binary-search ((low 1) (high N) (result N))
                (if (> low high)
                    result
                    (let* ((mid (quotient (+ low high) 2))
                           (val (let loop-total-diag ((c-start 0) (sum 0))
                                  (if (>= c-start mid)
                                      sum
                                      (loop-total-diag (+ c-start 1)
                                                       (+ sum (min rows (- mid c-start))))))))
                      (if (< val N)
                          (loop-binary-search (+ mid 1) high result)
                          (loop-binary-search low (- mid 1) mid))))))))
    (if (zero? N)
        ""
        (let* ((grid (make-vector rows (make-vector cols #\space)))
               (char-idx 0))
          (for ((c-start (in-range cols)))
            (for ((i (in-range rows)))
              (let ((r i)
                    (c (+ c-start i)))
                (when (< c cols)
                  (if (< char-idx N)
                      (begin
                        (vector-set! (vector-ref grid r) c (string-ref encodedText char-idx))
                        (set! char-idx (+ char-idx 1)))
                      (vector-set! (vector-ref grid r) c #\space))))))

          (let loop-collect-chars ((r 0) (c 0) (acc '()))
            (if (>= r rows)
                (let ((raw-text (list->string (reverse acc))))
                  (string-trim-right raw-text))
                (if (>= c cols)
                    (loop-collect-chars (+ r 1) 0 acc)
                    (loop-collect-chars r (+ c 1) (cons (vector-ref (vector-ref grid r) c) acc)))))))))