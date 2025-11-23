(define (minimum-string-length s)
  (define (remove-substring s substr)
    (let loop ((str s) (result ""))
      (cond
        [(string-contains str substr)
         (loop (string-append (substring str 0 (string-index str substr)) 
                              (substring str (+ (string-index str substr) (string-length substr)))) 
               "")]
        [else str])))

  (define (reduce-string s)
    (let loop ((current s))
      (let ((next (remove-substring current "ab")))
        (if (equal? next current)
            next
            (loop next)))))

  (string-length (reduce-string s)))