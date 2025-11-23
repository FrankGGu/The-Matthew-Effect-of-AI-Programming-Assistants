(define (can-be-valid s locked)
  (let ((n (string-length s)))
    (if (odd? n)
        #f
        (let ()
          ;; Left-to-right pass
          (define (check-left i balance wildcards)
            (cond
              ((= i n) #t) ; Successfully reached end of string
              (else
               (let* ((char-s (string-ref s i))
                      (char-locked (string-ref locked i)))

                 (let ((updated-balance
                        (if (char=? char-locked #\1) ; Locked
                            (if (char=? char-s #\()
                                (+ balance 1)
                                (- balance 1))
                            balance))
                       (updated-wildcards
                        (if (char=? char-locked #\0) ; Unlocked
                            (+ wildcards 1)
                            wildcards)))

                   (cond
                     ((< updated-balance 0) ; Too many ')'
                      (if (> updated-wildcards 0)
                          (check-left (+ i 1) (+ updated-balance 1) (- updated-wildcards 1)) ; Use a wildcard as '('
                          #f)) ; Cannot balance, return false
                     (else
                      (check-left (+ i 1) updated-balance updated-wildcards))))))))

          ;; Right-to-left pass
          (define (check-right i balance wildcards)
            (cond
              ((< i 0) #t) ; Successfully reached beginning of string
              (else
               (let* ((char-s (string-ref s i))
                      (char-locked (string-ref locked i)))

                 (let ((updated-balance
                        (if (char=? char-locked #\1) ; Locked
                            (if (char=? char-s #\)) ; For R-L, ')' increases balance (needs matching '(' later)
                                (+ balance 1)
                                (- balance 1))) ; '(' decreases balance
                            balance))
                       (updated-wildcards
                        (if (char=? char-locked #\0) ; Unlocked
                            (+ wildcards 1)
                            wildcards)))

                   (cond
                     ((< updated-balance 0) ; Too many '(' (for R-L pass)
                      (if (> updated-wildcards 0)
                          (check-right (- i 1) (+ updated-balance 1) (- updated-wildcards 1)) ; Use a wildcard as ')'
                          #f)) ; Cannot balance, return false
                     (else
                      (check-right (- i 1) updated-balance updated-wildcards))))))))

          ;; Execute passes
          (and (check-left 0 0 0) (check-right (- n 1) 0 0))))))