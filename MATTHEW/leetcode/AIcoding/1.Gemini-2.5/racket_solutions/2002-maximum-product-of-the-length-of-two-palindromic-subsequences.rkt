(define (is-palindrome? s)
  (let ((len (string-length s)))
    (if (<= len 1) #t
        (let loop ((i 0) (j (- len 1)))
          (if (>= i j) #t
              (if (char=? (string-ref s i) (string-ref s j))
                  (loop (+ i 1) (- j 1))
                  #f))))))

(define (max-product s)
  (let* ((n (string-length s))
         (max-mask (expt 2 n))
         (palindrome-lengths (make-vector max-mask 0)))

    (for ((mask (in-range 1 max-mask)))
      (let* ((sub-chars (for/list ((i (in-range n)))
                          (if (bitwise-bit-set? mask i)
                              (string-ref s i)
                              #f)))
             (sub-s (list->string (filter identity sub-chars))))
        (when (is-palindrome? sub-s)
          (vector-set! palindrome-lengths mask (string-length sub-s)))))

    (let ((max-prod 0))
      (for ((mask1 (in-range 1 max-mask)))
        (when (> (vector-ref palindrome-lengths mask1) 0)
          (for ((mask2 (in-range (+ mask1 1) max-mask)))
            (when (> (vector-ref palindrome-lengths mask2) 0)
              (when (= (bitwise-and mask1 mask2) 0)
                (set! max-prod (max max-prod
                                    (* (vector-ref palindrome-lengths mask1)
                                       (vector-ref palindrome-lengths mask2)))))))))
      max-prod)))