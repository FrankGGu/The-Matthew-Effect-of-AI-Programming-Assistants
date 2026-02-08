(define (longest-happy-prefix s)
  (define n (string-length s))
  (define lps (make-vector n 0))
  (let loop ((i 1) (j 0))
    (if (< i n)
        (begin
          (if (= (string-ref s i) (string-ref s j))
              (begin
                (set! j (+ j 1))
                (vector-set! lps i j)
                (loop (+ i 1) j))
              (if (> j 0)
                  (loop i (vector-ref lps (- j 1)))
                  (vector-set! lps i 0)
                  (loop (+ i 1) 0)))))
  (let ((length (vector-ref lps (- n 1))))
    (substring s 0 length)))

(longest-happy-prefix "level")