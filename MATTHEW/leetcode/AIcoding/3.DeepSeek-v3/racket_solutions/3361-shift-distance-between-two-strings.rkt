(define (can-convert s t)
  (let loop ((i 0)
             (mapping (make-hash)))
             (used-chars (make-hash)))
    (cond
      [(= i (string-length s)) #t]
      [else
       (let ((sc (string-ref s i))
             (tc (string-ref t i)))
         (if (hash-has-key? mapping sc)
             (if (char=? (hash-ref mapping sc) tc)
                 (loop (add1 i) mapping used-chars)
                 #f)
             (if (hash-has-key? used-chars tc)
                 #f
                 (begin
                   (hash-set! mapping sc tc)
                   (hash-set! used-chars tc #t)
                   (loop (add1 i) mapping used-chars)))))])))