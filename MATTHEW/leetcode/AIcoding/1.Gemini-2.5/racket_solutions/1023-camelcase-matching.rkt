(define (match-single-query query pattern)
  (let* ([n (string-length query)]
         [m (string-length pattern)])
    (let loop ([q-idx 0] [p-idx 0])
      (cond
        [(= q-idx n)
         (= p-idx m)]
        [else
         (let ([q-char (string-ref query q-idx)])
           (cond
             [(and (< p-idx m) (char=? q-char (string-ref pattern p-idx)))
              (loop (+ q-idx 1) (+ p-idx 1))]
             [(char-upper-case? q-char)
              #f]
             [else
              (loop (+ q-idx 1) p-idx)]))]))))

(define (camelMatch queries pattern)
  (map (lambda (query) (match-single-query query pattern)) queries))