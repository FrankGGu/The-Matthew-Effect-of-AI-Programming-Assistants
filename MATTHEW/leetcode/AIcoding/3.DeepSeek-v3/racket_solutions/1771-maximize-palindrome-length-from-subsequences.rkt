(define (longest-palindrome word1 word2)
  (let* ((s (string-append word1 word2))
         (n (string-length s))
         (dp (make-vector (vector-length (make-vector n (make-vector n 0))) (make-vector n 0))))
    (define (helper i j)
      (cond
        [(> i j) 0]
        [(= i j) 1]
        [(not (zero? (vector-ref (vector-ref dp i) j))) (vector-ref (vector-ref dp i) j)]
        [else
         (let ((res (if (char=? (string-ref s i) (string-ref s j))
                        (+ 2 (helper (+ i 1) (- j 1)))
                        (max (helper (+ i 1) j) (helper i (- j 1))))))
           (vector-set! (vector-ref dp i) j res)
           res)]))
    (let loop ((i 0) (res 0))
      (if (>= i (string-length word1))
          res
          (let loop2 ((j 0) (res res))
            (if (>= j (string-length word2))
                (loop (+ i 1) res)
                (if (char=? (string-ref word1 i) (string-ref word2 j))
                    (let ((current (+ 2 (helper (+ i 1) (+ (- n j) i (- (string-length word2) 1) 1)))))
                      (loop2 (+ j 1) (max res current)))
                    (loop2 (+ j 1) res))))))))