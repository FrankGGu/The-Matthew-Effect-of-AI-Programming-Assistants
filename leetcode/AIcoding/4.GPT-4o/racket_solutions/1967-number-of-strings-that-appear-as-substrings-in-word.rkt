(define (num-of-strings-appearing-as-substrings words word)
  (define (substring? sub str)
    (not (string-contains? str sub)))
  (define (count-strings words word)
    (foldl (lambda (w acc)
              (if (substring? w word) 
                  (+ acc 1)
                  acc)) 
            0 
            words))
  (count-strings words word))

(define (numOfStrings words word)
  (num-of-strings-appearing-as-substrings words word))