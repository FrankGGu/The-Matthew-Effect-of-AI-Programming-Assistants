(define (full-justify words max-width)
  (define (pack-words words max-width)
    (let loop ([lines '()]
               [current-line '()]
               [current-len 0]
               [remaining words])
      (if (null? remaining)
          (reverse (cons (reverse current-line) lines))
          (let* ([word (car remaining)]
                 [new-len (if (null? current-line)
                              (string-length word)
                              (+ current-len 1 (string-length word)))])
            (if (<= new-len max-width)
                (loop lines
                      (cons word current-line)
                      new-len
                      (cdr remaining))
                (loop (cons (reverse current-line) lines)
                      (list word)
                      (string-length word)
                      (cdr remaining))))))))

  (define (format-line line max-width is-last)
    (let ([words-count (length line)]
          [total-chars (apply + (map string-length line))])
      (cond
        [(or (= words-count 1) is-last)
         (string-join line " " #:after-last (make-string (- max-width total-chars (- words-count 1)) #\space))]
        [else
         (let* ([spaces-needed (- max-width total-chars)]
                [gaps (- words-count 1)]
                [base-space (quotient spaces-needed gaps)]
                [extra-spaces (remainder spaces-needed gaps)]
                [spaces (make-string base-space #\space)])
           (let loop ([result (car line)]
                      [remaining (cdr line)]
                      [extra extra-spaces])
             (if (null? remaining)
                 result
                 (loop (string-append result 
                                     spaces 
                                     (if (> extra 0) " " "")
                                     (car remaining))
                       (cdr remaining)
                       (if (> extra 0) (- extra 1) 0)))))])))

  (let ([lines (pack-words words max-width)])
    (for/list ([line (in-list (drop-right lines 1))]
               [i (in-naturals)])
      (format-line line max-width #f))
    (let ([last-line (last lines)])
      (format-line last-line max-width #t))))