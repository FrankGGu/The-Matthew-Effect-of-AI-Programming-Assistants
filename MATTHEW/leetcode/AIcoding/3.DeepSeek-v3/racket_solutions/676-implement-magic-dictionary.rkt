(define magic-dictionary%
  (class object%
    (super-new)
    (init-field)
    (field [dict '()])

    (define/public (build-dict dictionary)
      (set! dict dictionary))

    (define/public (search word)
      (define (one-char-different? a b)
        (if (not (= (string-length a) (string-length b)))
            #f
            (let loop ([i 0] [diff 0])
              (cond
                [(>= i (string-length a)) (= diff 1)]
                [(> diff 1) #f]
                [(char=? (string-ref a i) (string-ref b i)) (loop (add1 i) diff)]
                [else (loop (add1 i) (add1 diff))]))))
      (for/or ([w dict])
        (one-char-different? w word)))))