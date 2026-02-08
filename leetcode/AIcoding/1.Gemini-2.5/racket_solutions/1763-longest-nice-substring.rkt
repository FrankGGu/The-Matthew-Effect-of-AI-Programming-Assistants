(require racket/set)

(define (longest-nice-substring s)
  (define (solve s)
    (let ([n (string-length s)])
      (if (< n 2)
          "" ; Base case: empty or single character strings cannot be nice
          (let* ([s-list (string->list s)]
                 [char-set (list->set s-list)])
            (let loop ([i 0])
              (cond
                [(= i n) ; If loop finishes, s is nice
                 s]
                [else
                 (let ([char (list-ref s-list i)])
                   (if (char-alphabetic? char)
                       (let ([pair-char (if (char-lower-case? char)
                                            (char-upcase char)
                                            (char-downcase char))])
                         (if (set-contains? char-set pair-char)
                             (loop (+ i 1)) ; Current character is fine, continue
                             ; Found a problematic character, split the string
                             (let* ([left-s (substring s 0 i)]
                                    [right-s (substring s (+ i 1) n)]
                                    [res-left (solve left-s)]
                                    [res-right (solve right-s)])
                               (if (>= (string-length res-left) (string-length res-right))
                                   res-left
                                   res-right)))) ; Return the longer, or the left one if lengths are equal (earliest)
                       (loop (+ i 1))) ; Non-alphabetic character, ignore and continue
                   ))])))
  (solve s))