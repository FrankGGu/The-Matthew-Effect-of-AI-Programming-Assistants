(define (longest-special-substring-thrice s)
  (define (count-occurrences sub)
    (let loop ([str s] [count 0])
      (cond
        [(string=? str "") count]
        [(string-prefix? str sub) (loop (substring str (string-length sub)) (+ count 1))]
        [else (loop (substring str 1) count)])))

  (define (is-special sub)
    (and (> (string-length sub) 0)
         (let loop ([i 1])
           (cond
             [(>= i (string-length sub)) #t]
             [else (if (char=? (string-ref sub 0) (string-ref sub i))
                       (loop (+ i 1))
                       #f)]))))

  (let* ([n (string-length s)]
         [max-len 0])
    (for ([len (in-range n 0 -1)])
      (for ([i (in-range 0 (- n len 0))])
        (let ([sub (substring s i (+ i len))])
          (if (and (is-special sub) (> len max-len) (>= (count-occurrences sub) 3))
              (set! max-len len)))))
    max-len))