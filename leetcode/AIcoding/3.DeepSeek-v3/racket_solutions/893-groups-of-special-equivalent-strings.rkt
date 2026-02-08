(define/contract (num-special-equiv-groups words)
  (-> (listof string?) exact-integer?)
  (define (get-key s)
    (let ([even-chars (sort (for/list ([c (in-string s)] 
                              #:when (even? (string-length (take (string->list s) (string-index-of s c))))
                             c) char<?)]
          [odd-chars (sort (for/list ([c (in-string s)] 
                             #:when (odd? (string-length (take (string->list s) (string-index-of s c)))))
                            c) char<?)])
      (list even-chars odd-chars)))
  (set-count (list->set (map get-key words))))