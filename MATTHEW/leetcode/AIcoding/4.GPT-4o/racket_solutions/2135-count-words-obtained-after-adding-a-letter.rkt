(define (count-words-after-adding-a-letter startWords targetWords)
  (define (add-letter word)
    (for/list ([i (in-range (+ (string-length word) 1))])
      (string-append (substring word 0 i) "a" (substring word i))))

  (define start-set (set startWords))
  (define target-set (set targetWords))

  (define (count-valid-words)
    (for/fold ([count 0]) ([word startWords])
      (for ([new-word (add-letter word)])
        (if (set-member? target-set new-word)
            (+ count 1)
            count))))

  (count-valid-words))

(define startWords '("a" "ab" "ac"))
(define targetWords '("aa" "ab" "ac" "ad" "abc"))
(count-words-after-adding-a-letter startWords targetWords)