(define (str-str haystack needle)
  (let* ((haystack-len (string-length haystack))
         (needle-len (string-length needle)))
    (cond
      ((zero? needle-len) 0)
      ((> needle-len haystack-len) -1)
      (else
       (let loop ((i 0))
         (cond
           ((> (+ i needle-len) haystack-len) -1)
           ((string=? (substring haystack i (+ i needle-len)) needle) i)
           (else (loop (+ i 1)))))))))