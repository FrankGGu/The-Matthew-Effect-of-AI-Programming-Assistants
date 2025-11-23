(define (balanced-string? s)
  (define (count-chars str)
    (let ((counts (make-hash)))
      (for ([c (string->list str)])
        (hash-update! counts c add1 0))
      counts))

  (define counts (count-chars s))
  (if (hash-empty? counts)
      #t
      (let ((first-count (hash-ref counts (car (string->list s)))))
        (for/and ([c (string->list s)])
          (= (hash-ref counts c) first-count)))))