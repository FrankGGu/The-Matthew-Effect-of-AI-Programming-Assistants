(define (first-uniq-char s)
  (let* ([counts (make-hash)]
         [_ (for ([c (string->list s)])
              (hash-update! counts c (lambda (v) (+ v 1)) 1))]
         [indices (make-hash)]
         [_ (for/list ([c (in-string s)]
                     [i (in-range (string-length s))])
              (hash-update! indices (string-ref s i) (lambda (v) v) i))]
         [unique-chars (filter (lambda (c) (= (hash-ref counts c) 1)) (string->list s))])
    (if (null? unique-chars)
        -1
        (apply min (map (lambda (c) (hash-ref indices c)) unique-chars)))))