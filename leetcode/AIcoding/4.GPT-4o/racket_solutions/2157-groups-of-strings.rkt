(define (groupStrings strings)
  (define (shift str)
    (map (lambda (c) (char->integer (modulo (+ (char->integer c) 25) 26))) str))

  (define (normalize str)
    (map (lambda (c) (modulo (- (char->integer c) (char->integer (car str))) 26)) str))

  (define groups (make-hash))
  (for-each (lambda (s)
              (let ((n (normalize (string->list s))))
                (hash-set! groups n (cons s (hash-ref groups n '())))))
            strings)
  (hash->list groups))