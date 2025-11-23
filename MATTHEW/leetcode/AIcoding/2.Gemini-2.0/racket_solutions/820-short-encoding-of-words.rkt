(define (minimum-length-encoding words)
  (let* ([sorted-words (sort words string>?)]
         [result (string-append (car sorted-words) "#")]
         [len (string-length (car sorted-words))])
    (for ([word (cdr sorted-words)])
      (if (not (string-contains? result (string-append word "#")))
          (begin
            (set! result (string-append result word "#"))
            (set! len (+ len (string-length word) 1)))))
    len))