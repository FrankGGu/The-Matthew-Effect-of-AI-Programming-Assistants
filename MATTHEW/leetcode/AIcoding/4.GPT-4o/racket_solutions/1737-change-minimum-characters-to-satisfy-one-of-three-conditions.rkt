(define (min-changes a b)
  (define len (string-length a))
  (define (count-changes c)
    (let loop ((i 0) (changes 0))
      (if (< i len)
          (loop (+ i 1) 
                (+ changes 
                   (if (char=? (string-ref a i) c) 0 1) 
                   (if (char=? (string-ref b i) c) 0 1)))
          changes)))
  (let ((min-changes 1000))
    (for ([c (in-range 97 123)]) ; a to z
      (set! min-changes (min min-changes (count-changes (integer->char c)))))
    min-changes))