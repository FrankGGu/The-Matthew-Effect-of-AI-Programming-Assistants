(define (count-numbers n)
  (define (helper pos prev tight digits)
    (if (= pos (string-length digits))
        1
        (let* ([limit (if tight (char->integer (string-ref digits pos)) 9)]
               [start (if (= pos 0) 1 (max prev 0))])
          (for/sum ([d (in-range start (add1 limit))])
            (helper (add1 pos) d (and tight (= d limit)) digits))))
  (if (zero? n)
      1
      (helper 0 -1 #true (number->string n))))