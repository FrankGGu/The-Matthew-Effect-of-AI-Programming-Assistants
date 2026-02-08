(define/contract (match-replacement s sub mappings)
  (-> string? string? (listof (listof char?)) boolean?)
  (let ([n (string-length s)]
        [m (string-length sub)]
        [mapping (make-hash)])
    (for ([pair mappings])
      (hash-set! mapping (car pair) (cdr pair)))
    (let loop ([i 0])
      (cond
        [(> (+ i m) n) #f]
        [else
         (let ([match? #t])
           (for ([j (in-range m)] #:break (not match?))
             (let ([sc (string-ref s (+ i j))]
                   [tc (string-ref sub j)])
             (unless (or (char=? sc tc)
                         (let ([mapped (hash-ref mapping tc #f)])
                           (and mapped (char=? sc mapped))))
               (set! match? #f)))
           (if match? #t (loop (+ i 1))))]))))