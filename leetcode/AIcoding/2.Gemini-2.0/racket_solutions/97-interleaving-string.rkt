(define (is-interleave s1 s2 s3)
  (define len1 (string-length s1))
  (define len2 (string-length s2))
  (define len3 (string-length s3))

  (if (!= (+ len1 len2) len3)
      #f
      (letrec (
               (dp (make-vector (+ len1 1) (make-vector (+ len2 1) #f)))
               (solve
                (lambda (i j)
                  (cond
                    ((and (= i 0) (= j 0)) #t)
                    ((vector-ref (vector-ref dp i) j) (vector-ref (vector-ref dp i) j))
                    (else
                     (let ((res #f))
                       (if (and (> i 0) (char=? (string-ref s1 (- i 1)) (string-ref s3 (- (+ i j) 1))))
                           (set! res (or res (solve (- i 1) j))))
                       (if (and (> j 0) (char=? (string-ref s2 (- j 1)) (string-ref s3 (- (+ i j) 1))))
                           (set! res (or res (solve i (- j 1)))))
                       (vector-set! (vector-ref dp i) j res)
                       res)))))
               )
        (solve len1 len2))))