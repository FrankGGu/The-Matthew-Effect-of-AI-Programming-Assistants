(define (maximum-length-substring-with-two-occurrences s)
  (let* ([n (string-length s)]
         [max-len 0])
    (for* ([len (in-range n 0 -1)]
           [i (in-range (- n len) 0)])
      (let* ([sub (substring s i (+ i len))]
             [first-occurrence (string-index s sub)]
             [second-occurrence (and first-occurrence
                                       (string-index s sub (+ first-occurrence 1)))])
        (when second-occurrence
          (set! max-len (max max-len len)))))
    max-len))