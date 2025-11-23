(define (find-and-replace-pattern words pattern)
  (define (matches word)
    (define mapping (make-hash))
    (define used (make-hash))
    (define (helper w p)
      (cond
        [(and (null? w) (null? p)) #t]
        [(or (null? w) (null? p)) #f]
        [else
         (define c (car p))
         (define ch (car w))
         (define m (hash-ref mapping ch #f))
         (define u (hash-ref used c #f))
         (cond
           [(and m (not (equal? m c))) #f]
           [(and u (not (equal? u ch))) #f]
           [else
            (hash-set! mapping ch c)
            (hash-set! used c ch)
            (helper (cdr w) (cdr p))])])) 
    (helper (string->list word) (string->list pattern)))

  (filter matches words))

(find-and-replace-pattern '("abc" "deq" "mee" "aqq" "dkd" "ccc") "abb") ; Example usage