(define/contract (two-edit-words queries dictionary)
  (-> (listof string?) (listof string?) (listof string?))
  (define (edit-distance a b)
    (let loop ([i 0] [diff 0])
      (cond
        [(>= i (string-length a)) diff]
        [(>= diff 3) diff]
        [(char=? (string-ref a i) (string-ref b i)) (loop (add1 i) diff)]
        [else (loop (add1 i) (add1 diff))])))
  (filter
   (lambda (query)
     (ormap
      (lambda (word)
        (<= (edit-distance query word) 2))
      dictionary))
   queries))