(define (words-within-two-edits words dictionary)
  (define (diff-count s1 s2)
    (let ((len (string-length s1)))
      (for/sum ([i (in-range len)])
        (if (char=? (string-ref s1 i) (string-ref s2 i))
            0
            1))))

  (for/list ([word words]
             #:when (ormap (lambda (dict-word)
                             (and (= (string-length word) (string-length dict-word))
                                  (<= (diff-count word dict-word) 2)))
                           dictionary))
    word))