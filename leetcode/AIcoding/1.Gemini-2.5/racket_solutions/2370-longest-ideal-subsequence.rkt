(define (longest-ideal-subsequence s k)
  (let* ((len (string-length s))
         (dp (make-vector 26 0))
         (a-code (char->integer #\a))
         (max-len 0))

    (for ((i (in-range len)))
      (let* ((char-c (string-ref s i))
             (char-code (char->integer char-c))
             (char-idx (- char-code a-code))
             (current-max-prev-len 0))

        (for ((prev-char-idx (in-range (max 0 (- char-idx k))
                                        (add1 (min 25 (+ char-idx k))))))
          (set! current-max-prev-len (max current-max-prev-len (vector-ref dp prev-char-idx))))

        (vector-set! dp char-idx (+ 1 current-max-prev-len))
        (set! max-len (max max-len (vector-ref dp char-idx)))))

    max-len))