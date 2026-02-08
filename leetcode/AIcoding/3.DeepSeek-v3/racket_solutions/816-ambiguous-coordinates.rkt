#lang racket

(define (ambiguous-coordinates s)
  (define (valid s)
    (let* ([n (string-length s)]
           [has-decimal (for/or ([i (in-range 1 n)])
                         (char=? (string-ref s i) #\.)])
      (cond
        [(= n 1) #t]
        [(char=? (string-ref s 0) #\0)
         (and has-decimal (not (char=? (string-ref s (- n 1)) #\0)))]
        [else (or (not has-decimal) (not (char=? (string-ref s (- n 1)) #\0))))]))

  (define (generate s)
    (let ([res '()])
      (for ([i (in-range 1 (string-length s))])
        (let ([left (substring s 0 i)]
              [right (substring s i)])
          (when (and (valid left) (valid right))
            (set! res (cons (string-append "(" left ", " right ")") res)))))
      res))

  (let ([res '()]
        [s (substring s 1 (- (string-length s) 1))])
    (for ([i (in-range 1 (string-length s))])
      (let ([left (substring s 0 i)]
            [right (substring s i)])
        (let ([left-list (if (= (string-length left) 1)
                             (list left)
                             (let ([temp '()])
                               (for ([j (in-range 1 (string-length left))])
                                 (let ([a (substring left 0 j)]
                                       [b (substring left j)])
                                   (when (valid (string-append a "." b))
                                     (set! temp (cons (string-append a "." b) temp)))))
                               (if (valid left) (cons left temp) temp)))
              [right-list (if (= (string-length right) 1)
                              (list right)
                              (let ([temp '()])
                                (for ([j (in-range 1 (string-length right))])
                                  (let ([a (substring right 0 j)]
                                        [b (substring right j)])
                                    (when (valid (string-append a "." b))
                                      (set! temp (cons (string-append a "." b) temp)))))
                                (if (valid right) (cons right temp) temp)))])
          (for ([l left-list])
            (for ([r right-list])
              (set! res (cons (string-append "(" l ", " r ")") res)))))))
    res))