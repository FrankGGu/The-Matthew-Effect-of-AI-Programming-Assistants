(define (check-permutation s1 s2)
  (let* ((len1 (string-length s1))
         (len2 (string-length s2)))

    (if (> len1 len2)
        #f
        (let ()
          (define (make-char-counts s)
            (let ((counts (make-vector 26 0)))
              (for ([char (in-string s)])
                (let* ((idx (- (char->integer char) (char->integer #\a))))
                  (vector-set! counts idx (+ (vector-ref counts idx) 1))))
              counts))

          (let* ((s1-counts (make-char-counts s1))
                 (window-counts (make-vector 26 0))
                 (match-count 0))

            (for ([i (in-range len1)])
              (let* ((char (string-ref s2 i))
                     (idx (- (char->integer char) (char->integer #\a))))
                (vector-set! window-counts idx (+ (vector-ref window-counts idx) 1))))

            (for ([i (in-range 26)])
              (when (= (vector-ref s1-counts i) (vector-ref window-counts i))
                (set! match-count (+ match-count 1))))

            (if (= match-count 26)
                #t
                (let loop ([i len1])
                  (if (>= i len2)
                      #f
                      (begin
                        (let* ((char-out (string-ref s2 (- i len1)))
                               (idx-out (- (char->integer char-out) (char->integer #\a))))
                          (when (= (vector-ref s1-counts idx-out) (vector-ref window-counts idx-out))
                            (set! match-count (- match-count 1)))
                          (vector-set! window-counts idx-out (- (vector-ref window-counts idx-out) 1))
                          (when (= (vector-ref s1-counts idx-out) (vector-ref window-counts idx-out))
                            (set! match-count (+ match-count 1))))

                        (let* ((char-in (string-ref s2 i))
                               (idx-in (- (char->integer char-in) (char->integer #\a))))
                          (when (= (vector-ref s1-counts idx-in) (vector-ref window-counts idx-in))
                            (set! match-count (- match-count 1)))
                          (vector-set! window-counts idx-in (+ (vector-ref window-counts idx-in) 1))
                          (when (= (vector-ref s1-counts idx-in) (vector-ref window-counts idx-in))
                            (set! match-count (+ match-count 1))))

                        (if (= match-count 26)
                            #t
                            (loop (+ i 1)))))))))))