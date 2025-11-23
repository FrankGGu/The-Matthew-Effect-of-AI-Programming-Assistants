(define (group-anagrams strs)
  (define (string-to-sorted-string str)
    (list->string (sort (string->list str) char<?)))

  (define groups (make-hash))

  (for ([str strs])
    (let ([sorted-str (string-to-sorted-string str)])
      (hash-update! groups sorted-str (lambda (v) (cons str v)) (list str))))

  (hash-values groups))