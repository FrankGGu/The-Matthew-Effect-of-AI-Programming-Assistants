(define (anagram? s t)
  (if (not (= (string-length s) (string-length t)))
      #f
      (let ([s-counts (make-hash)]
            [t-counts (make-hash)])
        (for ([c (in-string s)])
          (hash-set! s-counts c (+ (hash-ref s-counts c 0) 1)))
        (for ([c (in-string t)])
          (hash-set! t-counts c (+ (hash-ref t-counts c 0) 1)))
        (equal? s-counts t-counts))))