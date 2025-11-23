(define (num-of-strings patterns word)
  (count (lambda (pattern) (string-contains? word pattern))
         patterns))