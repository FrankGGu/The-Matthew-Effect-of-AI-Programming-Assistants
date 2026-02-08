(define (interpret command)
  (define (helper cmd)
    (cond
      [(string=? cmd "") ""]
      [(string-prefix? cmd "G") (string-append "G" (helper (substring cmd 1)))]
      [(string-prefix? cmd "(al)") (string-append "al" (helper (substring cmd 4)))]
      [(string-prefix? cmd "(o)") (string-append "o" (helper (substring cmd 3)))]
      [else ""]))
  (helper command))