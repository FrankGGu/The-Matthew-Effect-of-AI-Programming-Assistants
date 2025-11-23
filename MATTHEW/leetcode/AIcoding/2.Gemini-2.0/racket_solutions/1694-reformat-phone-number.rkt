(define (reformat-number number)
  (let* ([digits (filter char-numeric? (string->list number))]
         [num-digits (length digits)])
    (if (zero? num-digits)
        ""
        (let loop ([remaining-digits digits]
                   [result ""])
          (cond
            [(null? remaining-digits)
             (substring result 1)]
            [(<= (length remaining-digits) 3)
             (string-append result "-" (list->string remaining-digits))]
            [(<= (length remaining-digits) 4)
             (string-append result "-" (list->string (take remaining-digits 2)) "-" (list->string (drop remaining-digits 2)))]
            [else
             (loop (drop remaining-digits 3)
                   (string-append result "-" (list->string (take remaining-digits 3))))]))))))