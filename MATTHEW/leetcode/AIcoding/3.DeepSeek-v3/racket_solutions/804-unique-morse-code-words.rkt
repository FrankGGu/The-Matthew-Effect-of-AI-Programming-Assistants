(define (unique-morse-representations words)
  (let ((morse-codes (list ".-" "-..." "-.-." "-.." "." "..-." "--." "...." ".." ".---" "-.-" ".-.." "--" "-." "---" ".--." "--.-" ".-." "..." "-" "..-" "...-" ".--" "-..-" "-.--" "--..")))
    (let ((morse-words (map (lambda (word)
                              (apply string-append
                                     (map (lambda (c)
                                            (list-ref morse-codes (- (char->integer c) (char->integer #\a))))
                                          (string->list word))))
                            words)))
      (length (remove-duplicates morse-words)))))