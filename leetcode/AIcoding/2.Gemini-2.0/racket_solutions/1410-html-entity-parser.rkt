(define (entity-parser text)
  (define entities
    '(("&quot;" . "\"")
      ("&apos;" . "'")
      ("&amp;" . "&")
      ("&gt;" . ">")
      ("&lt;" . "<")
      ("&frasl;" . "/")))

  (define (replace-entities str)
    (cond
      [(string=? str "") ""]
      [else
       (let loop ([str str])
         (cond
           [(string=? str "") ""]
           [else
            (let ([match (findf (lambda (entity) (string-prefix? str (car entity))) entities)])
              (if match
                  (string-append (cdr match) (loop (substring str (string-length (car match)))))
                  (string-append (substring str 0 1) (loop (substring str 1))))))])]))

  (replace-entities text))