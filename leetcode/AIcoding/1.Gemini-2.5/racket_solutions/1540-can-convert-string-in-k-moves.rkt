(define (can-convert-string s t k)
  (let* ((n (string-length s))
         (counts (make-vector 26 0)))

    (for ([i (in-range n)])
      (let* ((char-s (string-ref s i))
             (char-t (string-ref t i))
             (diff (- (char->integer char-t) (char->integer char-s))))
        (when (< diff 0)
          (set! diff (+ diff 26)))
        (when (> diff 0)
          (vector-set! counts diff (+ (vector-ref counts diff) 1)))))

    (let loop-d ((d 1))
      (cond
        ((> d 25) #t)
        (else
         (let ((num-needed (vector-ref counts d)))
           (let loop-j ((j 0))
             (cond
               ((>= j num-needed) (loop-d (+ d 1)))
               (else
                (let ((current-moves (+ d (* j 26))))
                  (if (> current-moves k)
                      #f
                      (loop-j (+ j 1))))))))))))