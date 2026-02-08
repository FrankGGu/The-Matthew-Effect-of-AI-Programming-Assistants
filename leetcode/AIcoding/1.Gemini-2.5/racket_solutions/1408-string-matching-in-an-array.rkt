(define (string-matching words)
  (define (is-substring-of-another? target-word all-words)
    (any (lambda (other-word)
           (and (not (string=? target-word other-word))
                (string-contains? other-word target-word)))
         all-words))

  (remove-duplicates
   (filter (lambda (word)
             (is-substring-of-another? word words))
           words)))