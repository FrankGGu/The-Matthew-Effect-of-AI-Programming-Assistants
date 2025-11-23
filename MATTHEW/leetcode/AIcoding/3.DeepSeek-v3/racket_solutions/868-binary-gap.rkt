(define (binary-gap n)
  (let loop ((n n) (max-gap 0) (current-gap 0) (found-one #f))
    (cond
      [(zero? n) max-gap]
      [(odd? n) (loop (arithmetic-shift n -1) 
                      (if found-one (max max-gap current-gap) max-gap)
                      1
                      #t)]
      [else (loop (arithmetic-shift n -1) 
                  max-gap 
                  (if found-one (add1 current-gap) current-gap) 
                  found-one)])))