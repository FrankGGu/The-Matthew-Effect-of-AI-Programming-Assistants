(define (count-valid-words sentence)
  (define (is-valid-word word)
    (and (not (string=? word ""))
         (not (string-contains? word ".")
              (string-contains? word ",")
              (string-contains? word "!"))
         (or (not (string-length> word 1))
             (not (char? (string-ref word (- (string-length word) 1)))
                  (char? (string-ref word (- (string-length word) 1)))))))

  (define words (string-split sentence))
  (define valid-words (filter is-valid-word words))
  (length valid-words))

(count-valid-words "Hello world!") ; Example usage