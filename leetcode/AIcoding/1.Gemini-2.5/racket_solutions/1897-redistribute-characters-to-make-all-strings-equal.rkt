(define (redistribute-characters words)
  (let* ((n (length words))
         (char-counts (make-hash)))

    (for-each (lambda (word)
                (for-each (lambda (char)
                            (hash-set! char-counts char (+ 1 (hash-ref char-counts char 0))))
                          (string->list word)))
              words)

    (andmap (lambda (count)
              (= (remainder count n) 0))
            (hash-values char-counts))))