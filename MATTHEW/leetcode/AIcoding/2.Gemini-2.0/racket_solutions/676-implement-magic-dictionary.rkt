(define magic-dictionary%
  (class object%
    (init-field words)
    (define/public (buildDict dict)
      (set! words dict))
    (define/public (search word)
      (for/or ([w (in-list words)])
        (and (= (string-length w) (string-length word))
             (= 1 (for/sum ([i (in-range (string-length word))])
                    (if (string=? (substring w i (+ i 1)) (substring word i (+ i 1)))
                        0
                        1))))))))

(define (make-magic-dictionary dict)
  (new magic-dictionary% [words dict]))