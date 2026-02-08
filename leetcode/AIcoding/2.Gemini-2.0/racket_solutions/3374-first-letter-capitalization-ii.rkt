(define (capitalize-title s)
  (string-join
   (map (lambda (word)
          (if (empty? word)
              ""
              (string-append (string-upcase (substring word 0 1))
                             (substring word 1))))
        (string-split s " "))
   " "))