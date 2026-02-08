(define (minimum-length-encoding words)
  (let* ([sorted-words (sort words (lambda (a b) (> (string-length a) (string-length b))))]
         [trie (make-hash)]
         [result 0])
    (for ([word sorted-words])
      (let loop ([node trie] [i (sub1 (string-length word))] [new? #f])
        (if (< i 0)
            (when new? (set! result (+ result (add1 (string-length word)))))
            (let ([c (string-ref word i)])
              (unless (hash-has-key? node c)
                (hash-set! node c (make-hash))
                (loop (hash-ref node c) (sub1 i) #t)))))))
    result))