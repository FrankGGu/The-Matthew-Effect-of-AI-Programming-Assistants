(define (valid-palindrome s)
  (define (alphanumeric? char)
    (or (char-alphabetic? char) (char-numeric? char)))

  (define (to-lower char)
    (if (char-upper-case? char)
        (char-downcase char)
        char))

  (define (filter-and-lowercase str)
    (list->string
     (filter
      (lambda (char) (alphanumeric? char))
      (map to-lower (string->list str)))))

  (define filtered-str (filter-and-lowercase s))

  (define (palindrome? str)
    (let loop ([start 0] [end (- (string-length str) 1)])
      (cond
        [(>= start end) #t]
        [(= (string-ref str start) (string-ref str end))
         (loop (+ start 1) (- end 1))]
        [else #f])))

  (palindrome? filtered-str))