(define (shortest-palindrome s)
  (let* ([n (string-length s)]
         [rev-s (string-copy s #:start 0 #:end n)]
         [_ (string-reverse! rev-s)]
         [combined (string-append s "#" rev-s)]
         [combined-len (string-length combined)]
         [lps (make-vector combined-len 0)]
         [len 0])
    (for ([i (in-range 1 combined-len)])
      (while (and (> len 0) (not (char=? (string-ref combined i) (string-ref combined len))))
        (set! len (vector-ref lps (- len 1))))
      (if (char=? (string-ref combined i) (string-ref combined len))
          (set! len (+ len 1)))
      (vector-set! lps i len))
    (let ([prefix-len (vector-ref lps (- combined-len 1))])
      (string-append (substring rev-s 0 (- n prefix-len)) s))))