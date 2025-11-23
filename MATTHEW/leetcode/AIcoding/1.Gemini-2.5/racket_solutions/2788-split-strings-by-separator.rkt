(define/public (split-words words separator)
  (append-map
   (lambda (word)
     (string-split word (string separator) #:trim-empty? #t))
   words))