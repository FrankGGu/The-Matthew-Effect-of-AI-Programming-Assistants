(define (find-anagrams s p)
  (let* ((s-len (string-length s))
         (p-len (string-length p)))

    (if (> p-len s-len)
        '()
        (let* ((p-freq (make-vector 26 0))
               (window-freq (make-vector 26 0))
               (results '()))

          (define (char->idx char)
            (- (char->integer char) (char->integer #\a)))

          (define (vectors-equal? vec1 vec2)
            (for/and ((i (in-range 26)))
              (= (vector-ref vec1 i) (vector-ref vec2 i))))

          (for ((i (in-range p-len)))
            (let ((idx (char->idx (string-ref p i))))
              (vector-set! p-freq idx (+ (vector-ref p-freq idx) 1))))

          (for ((i (in-range p-len)))
            (let ((idx (char->idx (string-ref s i))))
              (vector-set! window-freq idx (+ (vector-ref window-freq idx) 1))))

          (when (vectors-equal? p-freq window-freq)
            (set! results (cons 0 results)))

          (for ((left (in-range 1 (- s-len p-len))))
            (let* ((right (+ left p-len -1)))
              (let* ((char-to-remove (string-ref s (- left 1)))
                     (idx-to-remove (char->idx char-to-remove)))
                (vector-set! window-freq idx-to-remove (- (vector-ref window-freq idx-to-remove) 1)))

              (let* ((char-to-add (string-ref s right))
                     (idx-to-add (char->idx char-to-add)))
                (vector-set! window-freq idx-to-add (+ (vector-ref window-freq idx-to-add) 1))))

            (when (vectors-equal? p-freq window-freq)
              (set! results (cons left results))))

          (reverse results))))