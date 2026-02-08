(define (remove-all-occurrences s part)
  (let loop ([str s])
    (let ([index (string-contains str part)])
      (if index
          (loop (string-append (substring str 0 index) (substring str (+ index (string-length part)))))
          str))))