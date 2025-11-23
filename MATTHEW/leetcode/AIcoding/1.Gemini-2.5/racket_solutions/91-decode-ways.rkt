(define (num-decodings s)
  (let* ((n (string-length s))
         (dp (make-vector (+ n 1) 0)))

    (vector-set! dp 0 1)

    (when (> n 0)
      (let ((char1 (string-ref s 0)))
        (if (char=? char1 #\0)
            (vector-set! dp 1 0)
            (vector-set! dp 1 1))))

    (for ((i (in-range 2 (+ n 1))))
      (let* ((s-idx-1 (- i 1))
             (s-idx-2 (- i 2))
             (char1 (string-ref s s-idx-1))
             (digit1 (- (char->integer char1) (char->integer #\0)))

             (char2 (string-ref s s-idx-2))
             (digit2 (- (char->integer char2) (char->integer #\0)))

             (num (+ (* digit2 10) digit1)))

        (when (and (>= digit1 1) (<= digit1 9))
          (vector-set! dp i (+ (vector-ref dp i) (vector-ref dp (- i 1)))))

        (when (and (>= digit2 1) (>= num 10) (<= num 26))
          (vector-set! dp i (+ (vector-ref dp i) (vector-ref dp (- i 2)))))))

    (vector-ref dp n)))