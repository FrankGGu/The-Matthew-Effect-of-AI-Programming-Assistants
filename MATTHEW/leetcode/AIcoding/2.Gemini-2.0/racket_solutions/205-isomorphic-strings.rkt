(define (is-isomorphic s t)
  (let ((s-map (make-hash))
        (t-map (make-hash)))
    (cond
      [(not (= (string-length s) (string-length t))) #f]
      [else
       (let loop ((i 0))
         (if (= i (string-length s))
             #t
             (let* ((s-char (string-ref s i))
                    (t-char (string-ref t i))
                    (s-mapped (hash-ref s-map s-char #f))
                    (t-mapped (hash-ref t-map t-char #f)))
               (cond
                 [(and s-mapped t-mapped)
                  (and (char=? s-mapped t-char) (char=? t-mapped s-char))
                  (and (char=? s-mapped t-char) (char=? t-mapped s-char))
                  (loop (+ i 1))]
                 [(and (not s-mapped) (not t-mapped))
                  (hash-set! s-map s-char t-char)
                  (hash-set! t-map t-char s-char)
                  (loop (+ i 1))]
                 [else #f]))))]))))