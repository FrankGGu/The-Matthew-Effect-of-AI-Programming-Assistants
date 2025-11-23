(struct magic-dictionary
  ([words #:mutable])
  #:transparent)

(define (magic-dictionary-init)
  (magic-dictionary '()))

(define (magic-dictionary-build-dict this dict)
  (set-magic-dictionary-words! this dict))

(define (magic-dictionary-search this word)
  (let ([words (magic-dictionary-words this)])
    (for/or ([w words])
      (and (= (string-length w) (string-length word))
           (= (for/sum ([c1 (in-string w)]
                        [c2 (in-string word)]
                        #:unless (char=? c1 c2))
                1)
              1)))))