(define (reverse-substrings-between-each-pair-of-parentheses s)
  (define (solve s)
    (let loop ((i 0) (res ""))
      (cond
        [(= i (string-length s)) res]
        [(char=? (string-ref s i) #\()
         (let* ((j (find-closing-paren s i))
                (sub (substring s (+ i 1) j))
                (reversed-sub (string-reverse (solve sub))))
           (loop (+ j 1) (string-append res reversed-sub)))]
        [(char=? (string-ref s i) #\))
         (error "Unexpected closing parenthesis")]
        [else
         (loop (+ i 1) (string-append res (string (string-ref s i))))])))

  (define (find-closing-paren s start)
    (let loop ((i (+ start 1)) (count 1))
      (cond
        [(= i (string-length s)) (error "Unmatched opening parenthesis")]
        [(char=? (string-ref s i) #\() (loop (+ i 1) (+ count 1))]
        [(char=? (string-ref s i) #\)) (if (= count 1) i (loop (+ i 1) (- count 1)))]
        [else (loop (+ i 1) count)])))

  (solve s))