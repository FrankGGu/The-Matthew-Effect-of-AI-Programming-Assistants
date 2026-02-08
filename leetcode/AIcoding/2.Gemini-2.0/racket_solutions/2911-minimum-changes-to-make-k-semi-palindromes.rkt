(define (min-changes-k-semi-palindromes s k)
  (define n (string-length s))

  (define (is-semi-palindrome? sub)
    (let ((len (string-length sub)))
      (if (<= len 1)
          #t
          (let loop ((i 0) (j (- len 1)))
            (cond
              ((>= i j) #t)
              ((char=? (string-ref sub i) (string-ref sub j)) (loop (+ i 1) (- j 1)))
              (else #f))))))

  (define (cost sub)
    (let ((len (string-length sub)))
      (if (<= len 1)
          0
          (let loop ((i 0) (j (- len 1)) (count 0))
            (cond
              ((>= i j) count)
              ((char=? (string-ref sub i) (string-ref sub j)) (loop (+ i 1) (- j 1) count))
              (else (loop (+ i 1) (- j 1) (+ count 1))))))))

  (define (solve s k)
    (let ((n (string-length s)))
      (if (= k 1)
          (cost s)
          (if (<= k 0)
              #f
              (if (> k n)
                  0
                  (let ((dp (make-vector (+ n 1) (make-vector (+ k 1) #f))))
                    (vector-set! (vector-ref dp 0) 0 0)
                    (for* ((i (in-range 1 (+ n 1)))
                           (j (in-range 1 (+ k 1))))
                      (let loop ((l 1) (min-cost #f))
                        (if (> l i)
                            (vector-set! (vector-ref dp i) j min-cost)
                            (let* ((sub (substring s (- i l) i))
                                   (current-cost (cost sub))
                                   (prev-cost (vector-ref (vector-ref dp (- i l)) (- j 1))))
                              (if prev-cost
                                  (let ((total-cost (+ current-cost prev-cost)))
                                    (if min-cost
                                        (if (< total-cost min-cost)
                                            (loop (+ l 1) total-cost)
                                            (loop (+ l 1) min-cost))
                                        (loop (+ l 1) total-cost)))
                                  (loop (+ l 1) min-cost))))))
                    (vector-ref (vector-ref dp n) k)))))))
  (solve s k))