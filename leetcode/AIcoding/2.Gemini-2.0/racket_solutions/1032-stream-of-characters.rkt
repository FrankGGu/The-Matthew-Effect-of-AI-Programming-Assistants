(define (stream-checker words)
  (define trie (make-trie))
  (for ([word words])
    (trie-put! trie (reverse (string->list word)) #t))
  (define stream '())
  (define (query char)
    (set! stream (cons char stream))
    (let loop ([node trie] [chars stream])
      (cond
        [(trie-empty? node) #f]
        [(trie-ref node 'result #f) #t]
        [(null? chars) #f]
        [else
         (let ([c (car chars)])
           (loop (trie-ref node c #f) (cdr chars)))])))
  (cons query (lambda () (set! stream '()))))