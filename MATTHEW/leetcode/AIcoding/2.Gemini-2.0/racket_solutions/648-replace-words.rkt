(define (replace-words dict sentence)
  (define (prefix? word prefix)
    (and (<= (string-length prefix) (string-length word))
         (string=? (substring word 0 (string-length prefix)) prefix)))

  (define (find-shortest-prefix word)
    (let loop ([prefixes dict])
      (cond
        [(null? prefixes) word]
        [(prefix? word (car prefixes)) (car prefixes)]
        [else (loop (cdr prefixes))])))

  (string-join (map find-shortest-prefix (string-split sentence " ")) " "))