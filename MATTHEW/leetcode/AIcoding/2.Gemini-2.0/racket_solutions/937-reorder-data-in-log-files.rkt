(define (reorder-log-files logs)
  (define (is-digit-log? log)
    (char-numeric? (string-ref (cadr (string-split log " ")) 0)))

  (define (compare-log-files log1 log2)
    (let ([content1 (cadr (string-split log1 " "))]
          [content2 (cadr (string-split log2 " "))]
          [identifier1 (car (string-split log1 " "))]
          [identifier2 (car (string-split log2 " "))])
      (cond
        [(string<? content1 content2) -1]
        [(string>? content1 content2) 1]
        [else (cond
                [(string<? identifier1 identifier2) -1]
                [(string>? identifier1 identifier2) 1]
                [else 0])])))

  (let ([letter-logs (filter (lambda (log) (not (is-digit-log? log))) logs)]
        [digit-logs (filter is-digit-log? logs)])
    (append (sort letter-logs compare-log-files) digit-logs)))