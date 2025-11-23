(define (lexicographically-smallest-generated-string n)
  (let loop ((s "a"))
    (if (= (string-length s) n)
        s
        (let* ((next-b (string-append s "b"))
               (next-c (string-append s "c")))
          (cond
            [(string<? next-b next-c) (loop next-b)]
            [else (loop next-c)])))))