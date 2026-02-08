(define (unique-morse-representations words)
  (define morse-codes
    (vector ".-" "-..." "-.-." "-.." "." "..-." "--." "...." ".." ".---" "-.-" ".-.." "--" "-." "---" ".--." "--.-" ".-." "..." "-" "..-" "...-" ".--" "-..-" "-.--" "--.."))

  (define (word->morse-code word)
    (string-join
     (map (lambda (c)
            (vector-ref morse-codes (- (char->integer c) (char->integer #\a))))
          (string->list word))
     ""))

  (define unique-transforms (make-set))

  (for-each (lambda (word)
              (set-add! unique-transforms (word->morse-code word)))
            words)

  (set-count unique-transforms))