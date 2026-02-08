(define (count-segments s)
  (define (trim str)
    (let loop ([str str])
      (cond
        [(string=? str "") ""]
        [(char=? (string-ref str 0) #\space) (loop (substring str 1))]
        [(char=? (string-ref str (- (string-length str) 1)) #\space) (loop (substring str 0 (- (string-length str) 1)))]
        [else str])))

  (let ([trimmed-s (trim s)])
    (if (string=? trimmed-s "")
        0
        (length (string-split trimmed-s " ")))))