(define (get-happy-string n k)
  (define (num-happy-strings-starting-with-char len)
    (if (= len 0)
        1 ; Base case: 1 way to complete with an empty string (empty suffix)
        (expt 2 (- len 1))))

  (let ([total-happy-strings (* 3 (num-happy-strings-starting-with-char n))])
    (if (> k total-happy-strings)
        ""
        (let loop ([idx 0] [current-k k] [prev-char #\null] [current-string-chars '()])
          (if (= idx n)
              (list->string (reverse current-string-chars))
              (let* ([remaining-len (- n idx)]
                     [strings-per-choice (num-happy-strings-starting-with-char remaining-len)]
                     [possible-chars (cond
                                       [(char=? prev-char #\a) '(#\b #\c)]
                                       [(char=? prev-char #\b) '(#\a #\c)]
                                       [(char=? prev-char #\c) '(#\a #\b)]
                                       [else '(#\a #\b #\c)])]) ; For the first character

                (let-values ([(char-to-add next-k-val)]
                             (cond
                               ; First character selection (idx = 0)
                               [(and (= idx 0) (<= current-k strings-per-choice))
                                (values #\a current-k)]
                               [(and (= idx 0) (<= current-k (* 2 strings-per-choice)))
                                (values #\b (- current-k strings-per-choice))]
                               [(and (= idx 0) (<= current-k (* 3 strings-per-choice)))
                                (values #\c (- current-k (* 2 strings-per-choice)))]

                               ; Subsequent character selection (idx > 0)
                               [(<= current-k strings-per-choice)
                                (values (first possible-chars) current-k)]
                               [else ; current-k > strings-per-choice
                                (values (second possible-chars) (- current-k strings-per-choice))]))

                  (loop (+ idx 1) next-k-val char-to-add (cons char-to-add current-string-chars))))))))