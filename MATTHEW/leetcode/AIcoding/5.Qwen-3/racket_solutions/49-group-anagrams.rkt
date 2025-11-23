(define (group-anagrams strs)
  (define (sort-string s)
    (list->string (sort (string->list s) char<?)))
  (define (helper strs map)
    (cond [(null? strs) (map-values map)]
          [else
           (let* ([s (car strs)]
                  [key (sort-string s)])
             (helper (cdr strs)
                     (if (hash-has-key? map key)
                         (hash-set map key (cons s (hash-ref map key)))
                         (hash-set map key (list s)))))]))
  (helper strs (make-hash)))

(define (map-values h)
  (for/list ([(k v) (in-hash h)]) v))