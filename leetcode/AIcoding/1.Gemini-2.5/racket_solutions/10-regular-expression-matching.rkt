(define (is-match s p)
  (letrec ((dp (make-hash))

           (solve (lambda (s-idx p-idx)
                    (let* ((s-len (string-length s))
                           (p-len (string-length p))
                           (key (cons s-idx p-idx)))
                      (cond
                        ((hash-has-key? dp key) (hash-ref dp key))
                        (else
                         (let ((result
                                 (cond
                                   ((= p-idx p-len) (= s-idx s-len))

                                   ((and (< (+ p-idx 1) p-len) (char=? (string-ref p (+ p-idx 1)) #\*))
                                    (or
                                      (solve s-idx (+ p-idx 2))
                                      (and
                                        (< s-idx s-len)
                                        (or (char=? (string-ref p p-idx) #\.)
                                            (char=? (string-ref s s-idx) (string-ref p p-idx)))
                                        (solve (+ s-idx 1) p-idx))))

                                   (else
                                     (and
                                       (< s-idx s-len)
                                       (or (char=? (string-ref p p-idx) #\.)
                                           (char=? (string-ref s s-idx) (string-ref p p-idx)))
                                       (solve (+ s-idx 1) (+ p-idx 1))))))))

                           (hash-set! dp key result)
                           result))))))
    (solve 0 0)))