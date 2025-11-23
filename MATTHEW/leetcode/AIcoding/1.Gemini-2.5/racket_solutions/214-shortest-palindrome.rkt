(define (string-reverse s)
  (list->string (reverse (string->list s))))

(define (compute-lps-array pattern)
  (let* ([n (string-length pattern)]
         [lps (make-vector n 0)])
    (let loop ([i 1] [len 0])
      (when (< i n)
        (cond
          [(char=? (string-ref pattern i) (string-ref pattern len))
           (set! len (+ len 1))
           (vector-set! lps i len)
           (loop (+ i 1) len)]
          [(= len 0)
           (vector-set! lps i 0)
           (loop (+ i 1) 0)]
          [else
           (set! len (vector-ref lps (- len 1)))
           (loop i len)])))
    lps))

(define (shortest-palindrome s)
  (let* ([n (string-length s)])
    (cond
      [(= n 0) ""]
      [else
       (let* ([rev-s (string-reverse s)]
              [t (string-append s "#" rev-s)]
              [lps-array (compute-lps-array t)]
              [longest-palindromic-prefix-len (vector-ref lps-array (- (string-length t) 1))])
         (string-append
          (string-reverse (substring s longest-palindromic-prefix-len n))
          s))])))