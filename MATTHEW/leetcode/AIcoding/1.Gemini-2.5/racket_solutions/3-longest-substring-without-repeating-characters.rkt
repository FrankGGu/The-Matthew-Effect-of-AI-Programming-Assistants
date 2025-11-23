(define (length-of-longest-substring s)
  (let* ([n (string-length s)]
         [char-map (make-hash)]
         [max-len 0])
    (let loop ([right 0] [left 0])
      (if (= right n)
          max-len
          (let* ([current-char (string-ref s right)]
                 [prev-idx (hash-ref char-map current-char #f)])
            (when (and prev-idx (>= prev-idx left))
              (set! left (add1 prev-idx)))
            (hash-set! char-map current-char right)
            (set! max-len (max max-len (add1 (- right left))))
            (loop (add1 right) left))))))