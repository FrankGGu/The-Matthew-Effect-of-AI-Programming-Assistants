(define (group-anagrams strs)
  (define ht (make-hash))

  (for-each (lambda (s)
              (define sorted-s
                (list->string (sort (string->list s) char<?)))
              (hash-set! ht sorted-s
                         (cons s (hash-ref ht sorted-s '()))))
            strs)

  (hash-values ht))