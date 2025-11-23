(define (shortestCommonSupersequence str1 str2)
  (define n (string-length str1))
  (define m (string-length str2))
  (define dp (make-vector (+ n 1) (lambda () (make-vector (+ m 1) 0))))

  (for ([i (in-range 0 (+ n 1))])
    (vector-set! dp i (make-vector (+ m 1) 0)))

  (for ([i (in-range 1 (+ n 1))])
    (vector-set! (vector-ref dp i) 0 i))

  (for ([j (in-range 1 (+ m 1))])
    (vector-set! (vector-ref dp 0) j j))

  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 1 (+ m 1))])
      (if (char=? (string-ref str1 (- i 1)) (string-ref str2 (- j 1)))
          (begin
            (vector-set! (vector-ref dp i) j (+ 1 (vector-ref (vector-ref dp (- i 1)) (- j 1)))))
          (begin
            (vector-set! (vector-ref dp i) j (max (vector-ref (vector-ref dp (- i 1)) j) (vector-ref (vector-ref dp i) (- j 1))))))))

  (define i n)
  (define j m)
  (define result "")

  (let loop ()
    (cond
      [(= i 0) (set! result (string-append (make-string j #\0) result))
                (set! j 0)]
      [(= j 0) (set! result (string-append (make-string i #\0) result))
                (set! i 0)]
      [else
       (if (char=? (string-ref str1 (- i 1)) (string-ref str2 (- j 1)))
           (begin
             (set! result (string-append (string (string-ref str1 (- i 1))) result))
             (set! i (- i 1))
             (set! j (- j 1)))
           (if (> (vector-ref (vector-ref dp i) j) (vector-ref (vector-ref dp (- i 1)) j))
               (begin
                 (set! result (string-append (string (string-ref str1 (- i 1))) result))
                 (set! i (- i 1)))
               (begin
                 (set! result (string-append (string (string-ref str2 (- j 1))) result))
                 (set! j (- j 1))))))
      (if (or (> i 0) (> j 0)) (loop))))

  result)