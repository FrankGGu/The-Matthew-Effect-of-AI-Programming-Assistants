(define (min-add-to-make-parentheses-valid s)
  (let-values (((balance adds)
                (for/fold ((current-balance 0) (current-adds 0))
                          ((char (in-string s)))
                  (cond
                    ((char=? char #\()
                     (values (+ current-balance 1) current-adds))
                    ((char=? char #\))
                     (if (> current-balance 0)
                         (values (- current-balance 1) current-adds)
                         (values current-balance (+ current-adds 1))))
                    (else ; Should not happen for valid input, but good practice
                     (values current-balance current-adds))))))
    (+ balance adds)))