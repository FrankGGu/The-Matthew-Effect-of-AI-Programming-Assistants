(define (word-pattern pattern s)
  (define words (string-split s))
  (define hash1 (make-hash))
  (define hash2 (make-hash))
  (define (helper p w)
    (cond
      [(null? p) (null? w)]
      [(or (not (hash-has-key? hash1 (car p))) 
           (not (hash-has-key? hash2 (car w)))) 
       #f]
      [(not (equal? (hash-ref hash1 (car p)) (car w)))
       #f]
      [(not (equal? (hash-ref hash2 (car w)) (car p)))
       #f]
      [else (begin
              (hash-set! hash1 (car p) (car w))
              (hash-set! hash2 (car w) (car p))
              (helper (cdr p) (cdr w)))]))
  (if (not (= (length pattern) (length words))) 
      #f 
      (helper (string->list pattern) words)))