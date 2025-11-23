(define (max-unique-split s)
  (letrec ((helper (λ (str seen count)
                      (if (string=? str "")
                          count
                          (for/fold ([max-count 0])
                                    ([i (in-range 1 (add1 (string-length str)))])
                            (let* ([sub (substring str 0 i)]
                                   [rest (substring str i)])
                              (if (not (hash-has-key? seen sub))
                                  (max max-count (helper rest (hash-set seen sub #t) (add1 count)))
                                  max-count)))))))
    (helper s (make-hash) 0)))