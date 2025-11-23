(define (maxScoreWords words letters score)
  (define (count-letters lst)
    (foldl (lambda (x acc)
              (if (hash-ref acc x)
                  (hash-set! acc x (+ (hash-ref acc x) 1))
                  (hash-set! acc x 1))
              acc)
            (make-hash) lst))

  (define letter-count (count-letters letters))

  (define (score-word word)
    (foldl (lambda (c acc)
              (+ acc (hash-ref score (string->number (string c) 0))))
            0 word))

  (define (can-form-word? word)
    (define word-count (count-letters word))
    (for/fold ([result #t]) ([key (hash-keys word-count)])
      (and result (<= (hash-ref word-count key 0) (hash-ref letter-count key 0))))
  )

  (define (backtrack idx)
    (if (= idx (length words))
        0
        (let ([word (list-ref words idx)])
          (if (can-form-word? word)
              (max (+ (score-word word) (backtrack (+ idx 1)))
                   (backtrack (+ idx 1)))
              (backtrack (+ idx 1))))))

  (backtrack 0))