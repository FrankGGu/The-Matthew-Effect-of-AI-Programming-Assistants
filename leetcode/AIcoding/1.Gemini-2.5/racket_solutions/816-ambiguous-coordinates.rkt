(define (ambiguous-coordinates s)

  (define (valid-integer-part? num-str)
    (or (string=? num-str "0")
        (not (char=? (string-ref num-str 0) #\0))))

  (define (generate-valid-numbers digit-str)
    (let* ((len (string-length digit-str))
           (integer-form (if (valid-integer-part? digit-str) (list digit-str) '()))
           (decimal-forms
             (for/list ([i (in-range 1 len)]
                        #:when (let* ((left-part (substring digit-str 0 i))
                                       (right-part (substring digit-str i len)))
                                  (and (valid-integer-part? left-part)
                                       (not (char=? (string-ref right-part (- (string-length right-part) 1)) #\0)))))
               (string-append (substring digit-str 0 i) "." (substring digit-str i len)))))
      (append integer-form decimal-forms)))

  (let ((s-len (string-length s)))
    (apply append
           (for/list ([i (in-range 1 s-len)])
             (let* ((x-str (substring s 0 i))
                    (y-str (substring s i s-len))
                    (valid-xs (generate-valid-numbers x-str))
                    (valid-ys (generate-valid-numbers y-str)))
               (for/list ([vx valid-xs])
                 (for/list ([vy valid-ys])
                   (string-append "(" vx ", " vy ")"))))))))