(define (digit-sum-string s k)
  (define (sum-digits-in-string sub-s)
    (for/sum ([c (in-string sub-s)])
      (- (char->integer c) (char->integer #\0))))

  (let loop ([current-s s])
    (if (<= (string-length current-s) k)
        current-s
        (let* ([len (string-length current-s)]
               [new-parts (for/list ([i (in-range 0 len k)])
                            (let* ([end-idx (min (+ i k) len)]
                                   [sub-s (substring current-s i end-idx)]
                                   [sum (sum-digits-in-string sub-s)])
                              (number->string sum)))])
          (loop (string-append* new-parts))))))