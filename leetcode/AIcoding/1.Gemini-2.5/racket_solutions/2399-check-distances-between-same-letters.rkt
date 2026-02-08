(define (check-distances s distance)
  (let* ((len (string-length s))
         (first-occurrence (make-vector 26 -1)))

    (define (check-loop i)
      (if (= i len)
          #t ; All checks passed
          (let* ((char (string-ref s i))
                 (alpha-idx (- (char->integer char) (char->integer #\a))))
            (if (= (vector-ref first-occurrence alpha-idx) -1)
                (begin
                  (vector-set! first-occurrence alpha-idx i)
                  (check-loop (+ i 1)))
                (let ((idx1 (vector-ref first-occurrence alpha-idx))
                      (idx2 i))
                  (if (= (- idx2 idx1 1) (list-ref distance alpha-idx))
                      (check-loop (+ i 1))
                      #f)))))) ; Mismatch, return #f immediately

    (check-loop 0)))