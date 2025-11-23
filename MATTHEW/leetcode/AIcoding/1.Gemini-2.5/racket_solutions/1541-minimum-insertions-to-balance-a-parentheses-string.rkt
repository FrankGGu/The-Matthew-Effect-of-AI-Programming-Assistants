(define (min-insertions s)
  (let ([n (string-length s)])
    (let loop ([idx 0] [open-needed 0] [insertions 0])
      (cond
        [(= idx n) ; Base case: end of string
         (+ insertions (* open-needed 2))]
        [else
         (let ([char (string-ref s idx)])
           (cond
             [(char=? char #\( )
              (loop (+ idx 1) (+ open-needed 1) insertions)]
             [(char=? char #\) )
              (if (< (+ idx 1) n) ; Check if there's a next character
                  (let ([next-char (string-ref s (+ idx 1))])
                    (if (char=? next-char #\) ) ; Found "))"
                        (if (> open-needed 0)
                            (loop (+ idx 2) (- open-needed 1) insertions)
                            (loop (+ idx 2) open-needed (+ insertions 1)))
                        ; Found single ")"
                        (if (> open-needed 0)
                            (loop (+ idx 1) (- open-needed 1) (+ insertions 1))
                            (loop (+ idx 1) open-needed (+ insertions 2)))))
                  ; End of string, found single ")"
                  (if (> open-needed 0)
                      (loop (+ idx 1) (- open-needed 1) (+ insertions 1))
                      (loop (+ idx 1) open-needed (+ insertions 2)))))]))])))