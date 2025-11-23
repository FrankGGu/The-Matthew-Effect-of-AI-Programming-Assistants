(define (longest-happy-prefix s)
  (let* ([n (string-length s)]
         [lps (make-vector n 0)]
         [len 0]
         [i 1])
    (while (< i n)
      (cond
        [(string=? (substring s i (+ i 1)) (substring s len (+ len 1)))
         (set! len (+ len 1))
         (vector-set! lps i len)
         (set! i (+ i 1))]
        [(> len 0)
         (set! len (vector-ref lps (- len 1)))]
        [else
         (vector-set! lps i 0)
         (set! i (+ i 1))]))
    (substring s 0 (vector-ref lps (- n 1)))))