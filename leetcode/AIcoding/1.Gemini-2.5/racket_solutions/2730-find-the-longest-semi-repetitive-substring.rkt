(define (longest-semi-repetitive-substring s)
  (let* ([n (string-length s)]
         [chars (string->vector s)])
    (if (<= n 1)
        n
        (let loop ([left 0]
                   [right 0]
                   [pair-count 0]
                   [max-len 0])
          (if (= right n)
              max-len
              (let* ([current-char (vector-ref chars right)]
                     [prev-char (if (> right 0) (vector-ref chars (- right 1)) #\null)]
                     [new-pair-count (if (and (> right 0) (char=? current-char prev-char))
                                         (+ pair-count 1)
                                         pair-count)])
                (let loop-shrink ([l left]
                                  [pc new-pair-count])
                  (if (> pc 1)
                      (let* ([char-at-l (vector-ref chars l)]
                             [char-at-l+1 (vector-ref chars (+ l 1))]
                             [next-l (+ l 1)]
                             [next-pc (if (char=? char-at-l char-at-l+1)
                                          (- pc 1)
                                          pc)])
                        (loop-shrink next-l next-pc))
                      (loop l
                            (+ right 1)
                            pc
                            (max max-len (- (+ right 1) l)))))))))))