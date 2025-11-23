(define (capitalize-title title)
  (let ((words (string-split title)))
    (string-join
     (map (lambda (word)
            (if (<= (string-length word) 2)
                (string-downcase word)
                (string-titlecase word)))
          words)
     " ")))