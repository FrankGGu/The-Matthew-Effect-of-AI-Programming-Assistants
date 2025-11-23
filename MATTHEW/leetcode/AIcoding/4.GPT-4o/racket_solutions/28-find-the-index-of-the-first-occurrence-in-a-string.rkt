(define (strStr haystack needle)
  (if (zero? (string-length needle))
      0
      (let loop ((i 0))
        (if (>= i (- (string-length haystack) (string-length needle)))
            -1
            (if (string=? (substring haystack i (+ i (string-length needle))) needle)
                i
                (loop (+ i 1)))))))