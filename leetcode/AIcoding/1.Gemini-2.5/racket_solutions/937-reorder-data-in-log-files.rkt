#lang racket

(define (reorder-log-files logs)
  (define letter-logs '())
  (define digit-logs '())

  (for ([log logs])
    (define parts (string-split log " "))
    (define first-content-char (string-ref (cadr parts) 0))
    (if (char-numeric? first-content-char)
        (set! digit-logs (cons log digit-logs))
        (set! letter-logs (cons log letter-logs))))

  (set! letter-logs
        (sort letter-logs
              (lambda (log1 log2)
                (define parts1 (string-split log1 " "))
                (define id1 (car parts1))
                (define content1 (string-join (cdr parts1) " "))

                (define parts2 (string-split log2 " "))
                (define id2 (car parts2))
                (define content2 (string-join (cdr parts2) " "))

                (define content-cmp (string<? content1 content2))
                (if (not content-cmp) ; if content1 >= content2
                    (if (string=? content1 content2) ; if content1 == content2
                        (string<? id1 id2) ; compare by id
                        #f) ; content1 > content2, so log2 comes first (not log1)
                    #t)))) ; content1 < content2, so log1 comes first

  (append letter-logs (reverse digit-logs)))