(define (min-steps s t)
  (let* ((len (string-length s))
         (s-counts (make-vector 26 0))
         (t-counts (make-vector 26 0)))

    (for ((i (in-range len)))
      (let* ((char-s (string-ref s i))
             (idx (- (char->integer char-s) (char->integer #\a))))
        (vector-set! s-counts idx (+ (vector-ref s-counts idx) 1))))

    (for ((i (in-range len)))
      (let* ((char-t (string-ref t i))
             (idx (- (char->integer char-t) (char->integer #\a))))
        (vector-set! t-counts idx (+ (vector-ref t-counts idx) 1))))

    (let loop ((i 0) (steps 0))
      (if (= i 26)
          steps
          (let* ((s-count (vector-ref s-counts i))
                 (t-count (vector-ref t-counts i)))
            (loop (+ i 1) (+ steps (max 0 (- t-count s-count)))))))))