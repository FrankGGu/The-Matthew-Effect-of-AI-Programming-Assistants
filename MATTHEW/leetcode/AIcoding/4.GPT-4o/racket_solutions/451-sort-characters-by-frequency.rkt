(define (frequencySort s)
  (define freq-map (make-hash))
  (for-each (lambda (c)
              (hash-set! freq-map c (+ 1 (hash-ref freq-map c 0))))
            (string->list s))
  (define sorted-chars (sort (hash-map->list freq-map) (lambda (a b) (> (cdr a) (cdr b)))))
  (apply string-append (map (lambda (x) (make-string (cdr x) (car x))) sorted-chars)))

(frequencySort "tree")