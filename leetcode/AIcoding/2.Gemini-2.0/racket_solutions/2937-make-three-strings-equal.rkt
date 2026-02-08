(define (make-equal s1 s2 s3)
  (let* ([n1 (string-length s1)]
         [n2 (string-length s2)]
         [n3 (string-length s3)]
         [min-len (min n1 n2 n3)])
    (let loop ([i 0])
      (cond
        [(= i min-len)
         (- (+ n1 n2 n3) (* 3 i))]
        [(and (< i min-len)
              (char=? (string-ref s1 i) (string-ref s2 i))
              (char=? (string-ref s1 i) (string-ref s3 i)))
         (loop (+ i 1))]
        [else
         (+ n1 n2 n3)]))))