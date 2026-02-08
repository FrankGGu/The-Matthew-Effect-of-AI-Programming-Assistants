(define (longest-happy-prefix s)
  (let* ((n (string-length s))
         (lps (make-vector n 0)))

    (let loop ((len 0)
               (i 1))
      (when (< i n)
        (cond
          ((char=? (string-ref s i) (string-ref s len))
           (set! len (+ len 1))
           (vector-set! lps i len)
           (loop len (+ i 1)))
          (else
           (if (not (= len 0))
               (loop (vector-ref lps (- len 1)) i)
               (begin
                 (vector-set! lps i 0)
                 (loop 0 (+ i 1))))))))

    (let ((prefix-len (vector-ref lps (- n 1))))
      (substring s 0 prefix-len))))