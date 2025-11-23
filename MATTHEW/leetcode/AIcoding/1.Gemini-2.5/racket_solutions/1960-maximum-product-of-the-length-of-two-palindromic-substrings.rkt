(define (maximum-product s)
  (let* ((n (string-length s))
         (is-palindrome (make-vector n #f))
         (dp-prefix (make-vector n 0))
         (dp-suffix (make-vector n 0))
         (max-prod 0))

    (when (> n 0)
      ;; Initialize is-palindrome as a vector of vectors
      (for ((i (in-range n)))
        (vector-set! is-palindrome i (make-vector n #f)))

      ;; Step 1: Populate is-palindrome table
      (for ((len (in-range 1 (+ n 1))))
        (for ((i (in-range 0 (- n len -1))))
          (let ((j (+ i len -1)))
            (cond
              ((= len 1)
               (vector-set! (vector-ref is-palindrome i) j #t))
              ((= len 2)
               (when (char=? (string-ref s i) (string-ref s j))
                 (vector-set! (vector-ref is-palindrome i) j #t)))
              (else
               (when (and (char=? (string-ref s i) (string-ref s j))
                          (vector-ref (vector-ref is-palindrome (+ i 1)) (- j 1)))
                 (vector-set! (vector-ref is-palindrome i) j #t)))))))

      ;; Step 2: Populate dp-prefix
      (vector-set! dp-prefix 0 1)
      (for ((i (in-range 1 n)))
        (vector-set! dp-prefix i (vector-ref dp-prefix (- i 1)))
        (for ((k (in-range (+ i 1))))
          (when (vector-ref (vector-ref is-palindrome k) i)
            (vector-set! dp-prefix i
                         (max (vector-ref dp-prefix i)
                              (+ (- i k) 1))))))

      ;; Step 3: Populate dp-suffix
      (vector-set! dp-suffix (- n 1) 1)
      (for ((i (in-range (- n 2) -1 -1)))
        (vector-set! dp-suffix i (vector-ref dp-suffix (+ i 1)))
        (for ((k (in-range i n)))
          (when (vector-ref (vector-ref is-palindrome i) k)
            (vector-set! dp-suffix i
                         (max (vector-ref dp-suffix i)
                              (+ (- k i) 1))))))

      ;; Step 4: Calculate maximum product
      (for ((i (in-range (- n 1))))
        (set! max-prod (max max-prod
                            (* (vector-ref dp-prefix i)
                               (vector-ref dp-suffix (+ i 1)))))))

    max-prod))