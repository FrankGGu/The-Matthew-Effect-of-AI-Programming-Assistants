#lang racket

(define (capitalize-title title)
  (string-join
   (map (lambda (word)
          (let ((len (string-length word)))
            (cond
              ((< len 3) (string-downcase word))
              (else
               (string-append
                (string-upcase (substring word 0 1))
                (string-downcase (substring word 1)))))))
        (string-split title " "))
   " "))