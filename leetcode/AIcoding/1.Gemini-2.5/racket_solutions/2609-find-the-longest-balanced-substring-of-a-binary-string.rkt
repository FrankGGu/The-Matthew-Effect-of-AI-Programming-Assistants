(define (longest-balanced-substring s)
  (let* ((n (string-length s)))
    (if (= n 0)
        0
        (let-values (((max-len current-zeros current-ones)
                      (for/fold ((max-len 0)
                                 (current-zeros 0)
                                 (current-ones 0))
                                ((i (in-range n)))
                        (let ((char (string-ref s i)))
                          (if (char=? char #\0)
                              (if (> current-ones 0)
                                  (values max-len
                                          1
                                          0)
                                  (values max-len
                                          (+ current-zeros 1)
                                          0))
                              (if (> current-zeros 0)
                                  (let ((new-ones (+ current-ones 1)))
                                    (values (max max-len (* 2 (min current-zeros new-ones)))
                                            current-zeros
                                            new-ones))
                                  (values max-len
                                          0
                                          0)))))))
          max-len))))