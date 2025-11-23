(define (min-operations s1 s2 x)
  (let loop ((i 0) (cost 0) (flip? #f))
    (cond
      [(>= i (string-length s1)) (if flip? +inf.0 cost)]
      [(char=? (string-ref s1 i) (if flip? (if (char=? (string-ref s2 i) #\0) #\1 #\0) (string-ref s2 i)))
       (loop (add1 i) cost flip?)]
      [else
       (let ((option1 (if (< (add1 i) (string-length s1))
                          (loop (add1 i) (add1 cost) (not flip?))
                          +inf.0))
             (option2 (if (< (add1 i) (string-length s1))
                          (loop (+ i 2) (+ cost x) flip?)
                          +inf.0)))
         (min option1 option2))])))