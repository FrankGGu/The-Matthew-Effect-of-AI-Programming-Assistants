(define (find-num-of-valid-words words puzzles)
  (define (word->mask word)
    (for/fold ([mask 0]) ([c (in-string word)])
      (bitwise-ior mask (arithmetic-shift 1 (- (char->integer c) (char->integer #\a))))))

  (define (puzzle->mask puzzle)
    (for/fold ([mask 0]) ([c (in-string puzzle)])
      (bitwise-ior mask (arithmetic-shift 1 (- (char->integer c) (char->integer #\a))))))

  (define (is-valid? word-mask puzzle-mask first-char-mask)
    (and (bitwise-and word-mask puzzle-mask)
         (= word-mask (bitwise-and word-mask puzzle-mask))
         (not (= 0 (bitwise-and word-mask first-char-mask)))))

  (define word-masks (map word->mask words))
  (define (solve-puzzle puzzle)
    (define puzzle-mask (puzzle->mask puzzle))
    (define first-char-mask (arithmetic-shift 1 (- (char->integer (string-ref puzzle 0)) (char->integer #\a))))
    (length (filter (lambda (word-mask) (is-valid? word-mask puzzle-mask first-char-mask)) word-masks)))

  (map solve-puzzle puzzles))