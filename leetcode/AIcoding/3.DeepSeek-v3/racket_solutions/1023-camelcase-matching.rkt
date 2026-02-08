(define/contract (camel-match queries pattern)
  (-> (listof string?) string? (listof boolean?))
  (define (match-query query pattern)
    (let loop ([q 0] [p 0])
      (cond
        [(= q (string-length query)) (= p (string-length pattern))]
        [(= p (string-length pattern)) 
         (andmap char-lower-case? (substring query q))]
        [(char=? (string-ref query q) (string-ref pattern p))
         (loop (add1 q) (add1 p))]
        [(char-lower-case? (string-ref query q))
         (loop (add1 q) p)]
        [else #f])))
  (map (lambda (query) (match-query query pattern)) queries))