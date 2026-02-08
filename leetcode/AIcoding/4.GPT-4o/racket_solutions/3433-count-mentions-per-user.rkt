(define (count-mentions tweets)
  (define user-mentions (make-hash))
  (for-each (lambda (tweet)
              (define parts (string-split tweet))
              (define user (first parts))
              (for-each (lambda (mention)
                          (hash-set! user-mentions mention
                                      (+ (hash-ref user-mentions mention 0) 1)))
                        (filter (lambda (word) (string-starts-with? word "@"))
                                (rest parts))))
            tweets)
  (hash->list user-mentions))

(define (string-split str)
  (string-split str " "))

(define (string-starts-with? str prefix)
  (and (>= (string-length str) (string-length prefix))
       (string=? (substring str 0 (string-length prefix)) prefix)))