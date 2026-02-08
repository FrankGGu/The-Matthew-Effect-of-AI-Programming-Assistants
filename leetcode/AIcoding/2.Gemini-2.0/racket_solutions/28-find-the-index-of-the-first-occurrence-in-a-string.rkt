(define (strStr haystack needle)
  (let ([haystack-len (string-length haystack)]
        [needle-len (string-length needle)])
    (if (zero? needle-len)
        0
        (let loop ([i 0])
          (cond
            [(>= i (- haystack-len needle-len) 1) -1]
            [(string=? (substring haystack i (+ i needle-len)) needle) i]
            [else (loop (+ i 1))])))))