(define (find-valid-pair s)
  (let loop ((i 0))
    (cond
      [(>= i (- (string-length s) 1)) -1]
      [(or (and (char=? (string-ref s i) #\()
               (char=? (string-ref s (+ i 1)) #\)))
           (or (and (char=? (string-ref s i) #\[)
                    (char=? (string-ref s (+ i 1)) #\]))
                i)
               (and (char=? (string-ref s i) #\{)
                    (char=? (string-ref s (+ i 1)) #\}))
                i)
           i)]
      [else (loop (+ i 1))])))