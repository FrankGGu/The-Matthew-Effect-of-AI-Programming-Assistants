(define (convert s numRows)
  (if (or (zero? numRows) (>= (string-length s) numRows))
      s
      (let loop ((i 0) (rows (make-vector numRows '())))
        (if (< i (string-length s))
            (begin
              (let ((row (modulo i (* 2 (- numRows 1)))))
                (if (or (= row 0) (= row (- numRows 1)))
                    (vector-set! rows row (string-append (vector-ref rows row) (string (string-ref s i))))
                    (let ((j (- (* 2 numRows 1) row)))
                      (vector-set! rows row (string-append (vector-ref rows row) (string (string-ref s i))))
                      (vector-set! rows j (string-append (vector-ref rows j) (string (string-ref s i)))))))
              (loop (+ i 1) rows))
            (apply string-append (vector->list rows))))))