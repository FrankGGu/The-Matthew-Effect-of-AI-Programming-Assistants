(define (findNumOfValidWords words puzzles)
  (define (word-mask word)
    (foldl (lambda (ch acc) (bitwise-ior acc (ash 1 (- (char->integer ch) (char->integer #\a))))) 0 word))

  (define (puzzle-mask puzzle)
    (foldl (lambda (ch acc) (bitwise-ior acc (ash 1 (- (char->integer ch) (char->integer #\a))))) 0 (substring puzzle 1)))

  (define words-masks (map word-mask words))
  (define puzzles-masks (map puzzle-mask puzzles))

  (define (valid-count puzzle-mask first-char-mask)
    (define (count valid-words)
      (foldl (lambda (word acc) (if (and (bitwise-and puzzle-mask word) 
                                           (bitwise-and first-char-mask word)) 
                                     (+ acc 1) 
                                     acc)) 
             0 valid-words))
    (count words-masks))

  (map (lambda (puzzle) 
         (valid-count (puzzle-mask puzzle) (ash 1 (- (char->integer (string-ref puzzle 0)) (char->integer #\a))))) 
       puzzles))

(findNumOfValidWords words puzzles)