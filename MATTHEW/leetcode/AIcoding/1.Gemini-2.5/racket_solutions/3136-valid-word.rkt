(define (is-valid-word s)
  (let ([len (string-length s)])
    (if (< len 3)
        #f
        (let-values ([(has-vowel? has-consonant? all-alphanumeric?)
                      (for/fold ([hv #f] [hc #f] [aa #t])
                                ([c (in-string s)])
                        (if (not aa)
                            (values hv hc #f) ; If already found a non-alphanumeric, propagate #f
                            (if (char-alphanumeric? c)
                                (let ([lc (char-downcase c)])
                                  (values (or hv (member lc '(#\a #\e #\i #\o #\u)))
                                          (or hc (and (char-alphabetic? c) (not (member lc '(#\a #\e #\i #\o #\u)))))
                                          #t))
                                (values hv hc #f))))]) ; Found a non-alphanumeric character
          (and all-alphanumeric? has-vowel? has-consonant?)))))