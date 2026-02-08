(define (longest-common-suffix-queries words queries)
  (define (suffixes word)
    (let loop ((s word) (acc '()))
      (if (string=? s "")
          acc
          (loop (substring s 1) (cons s acc)))))

  (define suffix-map
    (for/hash ([word words])
      (for/fold ([suff '()]) ([s (suffixes word)])
        (hash-set suff (add1 (hash-ref suff (default 0) 0))))))

  (map (lambda (query)
         (define suffix (make-string (string-length query)))
         (define count (hash-ref suffix-map query 0))
         count)
       queries))

(define words '("flower" "flow" "flight"))
(define queries '("low" "ight" "er" "ly"))
(longest-common-suffix-queries words queries)