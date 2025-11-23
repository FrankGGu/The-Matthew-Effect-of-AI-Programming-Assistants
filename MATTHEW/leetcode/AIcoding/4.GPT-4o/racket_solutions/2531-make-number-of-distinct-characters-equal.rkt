(define (makeEqual words)
  (define freq (make-hash))
  (for-each (lambda (word)
              (for-each (lambda (char)
                          (hash-set! freq char (+ (hash-ref freq char 0) 1)))
                        (string->list word)))
            words)
  (define total (apply + (hash-values freq)))
  (equal? (mod total (hash-count freq)) 0))

(define (main)
  (makeEqual '("abc" "aabc" "bc")))

(main)