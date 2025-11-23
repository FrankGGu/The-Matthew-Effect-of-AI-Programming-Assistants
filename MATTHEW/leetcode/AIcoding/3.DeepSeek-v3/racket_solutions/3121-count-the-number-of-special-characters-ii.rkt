(define (numberOfSpecialChars word)
  (let ((lower (make-hash))
        (upper (make-hash))
        (special (make-hash)))
    (for ([c word])
      (if (char-lowercase? c)
          (hash-set! lower c #t)
          (hash-set! upper c #t)))
    (let loop ([count 0]
               [keys (hash-keys lower)])
      (if (null? keys)
          count
          (let* ([c (car keys)]
                 [upper-c (char-upcase c)])
            (if (and (hash-has-key? upper upper-c)
                     (not (hash-has-key? special upper-c)))
                (loop (add1 count) (cdr keys))
                (loop count (cdr keys)))))))