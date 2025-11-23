(define (group-anagrams strs)
  (define (sort-string s)
    (list->string (sort (string->list s) char<?)))
  (define (helper strs map)
    (cond [(null? strs) (map-values map)]
          [else
           (let* ([s (car strs)]
                  [key (sort-string s)])
             (helper (cdr strs) (hash-set map key (cons s (hash-ref map key '())))))]))
  (helper strs (make-hash)))