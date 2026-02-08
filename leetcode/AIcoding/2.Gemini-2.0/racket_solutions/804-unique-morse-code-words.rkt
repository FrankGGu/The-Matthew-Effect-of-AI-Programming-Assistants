(define (unique-morse-representations words)
  (define morse-codes
    (vector
     ".-"   "-..." "-.-." "-.."  "."    "..-." "--."
     "...." ".."   ".---" "-.-"  ".-.." "--"   "-."
     "---"  ".--." "--.-" ".-."  "..."  "-"    "..-"
     "...-" ".--"  "-..-" "-.--" "--.."))

  (define (to-morse word)
    (string-append* (map (lambda (c) (vector-ref morse-codes (- (char->integer c) (char->integer #\a))))
                          (string->list word))))

  (length (remove-duplicates (map to-morse words) equal?)))