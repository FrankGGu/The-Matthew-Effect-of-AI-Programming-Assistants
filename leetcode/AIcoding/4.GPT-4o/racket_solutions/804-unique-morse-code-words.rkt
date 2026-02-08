(define (uniqueMorseRepresentations words)
  (define morse-code (vector ".-" "-..." "-.-." "-.." "." "..-." "--." "...." ".." ".---" "-.-" ".-.." "--" "-." "---" ".--." "--.-" ".-." "..." "-" "..-" "...-" ".--" "-..-" "-.--" "--.."))
  (define (word-to-morse word)
    (apply string-append (map (lambda (c) (vector-ref morse-code (- (char->integer c) (char->integer #\a)))) (string->list word))))
  (define unique-morse (make-hash))
  (for-each (lambda (word) (hash-set! unique-morse (word-to-morse word) #t)) words)
  (hash-count unique-morse))

(uniqueMorseRepresentations '("gin" "zen" "gig" "msg"))