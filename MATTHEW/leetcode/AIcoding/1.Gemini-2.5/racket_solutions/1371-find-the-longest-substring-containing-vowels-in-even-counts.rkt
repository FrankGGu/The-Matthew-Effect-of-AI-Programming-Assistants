(define (find-the-longest-substring s)
  (let* ([n (string-length s)]
         [max-len 0]
         [current-mask 0]
         [seen-masks (make-hash)])
    (hash-set! seen-masks 0 -1)

    (for ([i (in-range n)])
      (let ([char (string-ref s i)])
        (set! current-mask
              (case char
                [(#\a) (bitwise-xor current-mask 1)]
                [(#\e) (bitwise-xor current-mask 2)]
                [(#\i) (bitwise-xor current-mask 4)]
                [(#\o) (bitwise-xor current-mask 8)]
                [(#\u) (bitwise-xor current-mask 16)]
                [else current-mask]))

        (if (hash-has-key? seen-masks current-mask)
            (set! max-len (max max-len (- i (hash-ref seen-masks current-mask))))
            (hash-set! seen-masks current-mask i))))
    max-len))