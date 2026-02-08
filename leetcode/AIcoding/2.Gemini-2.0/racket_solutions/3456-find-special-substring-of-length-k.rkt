(define (special-substrings s k)
  (let ([n (string-length s)])
    (if (< n k)
        0
        (let loop ([i 0] [count 0] [seen (make-hash)])
          (cond
            [(>= i (- n k 0)) count]
            [else
             (let ([sub (substring s i (+ i k))])
               (let loop2 ([j 0] [valid? #t])
                 (cond
                   [(>= j k)
                    (if valid?
                        (let ([exists? (hash-has-key? seen sub)])
                          (if exists?
                              (loop (+ i 1) count seen)
                              (begin
                                (hash-set! seen sub #t)
                                (loop (+ i 1) (+ count 1) seen))))
                        (loop (+ i 1) count seen))]
                   [else
                    (let ([c (string-ref sub j)])
                      (if (or (char<=? #\a c #\z) (char<=? #\A c #\Z))
                          (loop2 (+ j 1) valid?)
                          (loop2 (+ j 1) #f)))])))]))))))