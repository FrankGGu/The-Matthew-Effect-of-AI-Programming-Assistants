(define (is-substring-reverse s)
  (define (reverse str)
    (list->string (reverse (string->list str))))

  (define (exists? sub)
    (not (equal? (string-contains s sub) #f)))

  (define len (string-length s))

  (for/or ([i (in-range len)])
    (let ([sub (substring s i (+ i 1))])
      (exists? (reverse sub)))))

(define (check-string s)
  (define substrings (for/list ([i (in-range (string-length s))])
                       (for/list ([j (in-range i (+ i 1 (string-length s)))])
                         (substring s i j))))
  (for/or ([sub substrings])
    (is-substring-reverse sub)))

(check-string "your_input_string_here")