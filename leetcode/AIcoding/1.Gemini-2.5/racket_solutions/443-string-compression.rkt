(define (compress chars)
  (let* ([n (vector-length chars)]
         [write-idx 0])
    (let loop ((read-idx 0) (write-idx write-idx))
      (if (>= read-idx n)
          write-idx
          (let* ([current-char (vector-ref chars read-idx)])
            (let count-loop ((r-idx read-idx) (count 0))
              (if (and (< r-idx n) (char=? (vector-ref chars r-idx) current-char))
                  (count-loop (+ r-idx 1) (+ count 1))
                  (begin
                    (vector-set! chars write-idx current-char)
                    (let ([next-write-idx (+ write-idx 1)])
                      (if (> count 1)
                          (let* ([count-str (number->string count)]
                                 [num-digits (string-length count-str)])
                            (let write-digits-loop ((digit-idx 0) (current-w-idx next-write-idx))
                              (if (< digit-idx num-digits)
                                  (begin
                                    (vector-set! chars current-w-idx (string-ref count-str digit-idx))
                                    (write-digits-loop (+ digit-idx 1) (+ current-w-idx 1)))
                                  (loop r-idx current-w-idx))))
                          (loop r-idx next-write-idx))))))))))