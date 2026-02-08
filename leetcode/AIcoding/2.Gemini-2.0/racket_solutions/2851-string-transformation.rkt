(define (string-transformation s t)
  (define (build-map s t)
    (let loop ([s-list (string->list s)]
               [t-list (string->list t)]
               [mapping (hash)])
      (cond
        [(empty? s-list) mapping]
        [else
         (let ([s-char (car s-list)]
               [t-char (car t-list)])
           (cond
             [(hash-has-key? mapping s-char)
              (if (equal? (hash-ref mapping s-char) t-char)
                  (loop (cdr s-list) (cdr t-list) mapping)
                  #f)]
             [else
              (loop (cdr s-list) (cdr t-list) (hash-set mapping s-char t-char))]))])))

  (and (equal? (string-length s) (string-length t))
       (let ([forward-map (build-map s t)]
             [backward-map (build-map t s)])
         (and forward-map backward-map))))