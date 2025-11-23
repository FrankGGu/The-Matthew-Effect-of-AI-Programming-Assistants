(define (longest-special-substring-thrice s)
  (let* ([n (string-length s)]
         [longest 0])
    (for* ([len (in-range n 1 -1)]
           [i (in-range (- n len) 0)])
      (let* ([sub (substring s i (+ i len))]
             [count 0])
        (for ([j (in-range (- n len) 0)])
          (when (equal? sub (substring s j (+ j len)))
            (set! count (+ count 1))))
        (when (>= count 3)
          (set! longest (max longest len))
          (return #void))))
    longest))