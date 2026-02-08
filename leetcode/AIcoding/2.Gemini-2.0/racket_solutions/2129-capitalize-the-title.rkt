(define (capitalize-title title)
  (string-join
   (map (lambda (word)
          (if (<= (string-length word) 2)
              (string-downcase word)
              (string-titlecase word)))
        (string-split title))
   " "))