(define (last-substring-in-lexicographical-order s)
  (let* ((n (string-length s)))
    (if (= n 0)
        ""
        (let loop ((i 0) (j 1) (k 0))
          (cond
            ((>= (+ j k) n)
             (substring s i n))
            ((char=? (string-ref s (+ i k)) (string-ref s (+ j k)))
             (loop i j (+ k 1)))
            ((char<? (string-ref s (+ i k)) (string-ref s (+ j k)))
             (loop j (+ j 1) 0))
            (else
             (loop i (+ j 1) 0)))))))