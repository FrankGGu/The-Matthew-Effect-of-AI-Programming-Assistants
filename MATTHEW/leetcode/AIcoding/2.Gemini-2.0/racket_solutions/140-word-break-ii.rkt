(define (word-break s word-dict)
  (define (word-break-helper s word-dict memo)
    (cond
      [(hash-has-key? memo s) (hash-ref memo s)]
      [(= (string-length s) 0) (list "")]
      [else
       (let loop ([i 1] [result '()])
         (cond
           [(> i (string-length s))
            (hash-set! memo s result)
            result]
           [else
            (let ([prefix (substring s 0 i)])
              (if (member prefix word-dict)
                  (let ([suffix (substring s i (string-length s))]
                        [suffix-sentences (word-break-helper suffix word-dict memo)])
                    (let ([new-sentences
                           (map (lambda (suffix-sentence)
                                  (if (equal? suffix-sentence "")
                                      prefix
                                      (string-append prefix " " suffix-sentence)))
                                suffix-sentences)])
                      (loop (+ i 1) (append result new-sentences))))
                  (loop (+ i 1) result))))])]))
  (word-break-helper s (set->list word-dict) (make-hash)))