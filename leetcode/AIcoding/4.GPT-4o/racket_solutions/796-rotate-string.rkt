(define (rotate-string A B)
  (and (= (string-length A) (string-length B))
       (string-contains? (string-append A A) B)))