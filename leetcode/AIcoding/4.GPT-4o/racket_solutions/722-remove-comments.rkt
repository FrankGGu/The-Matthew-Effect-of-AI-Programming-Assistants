(define (remove-comments source)
  (define (process-line line in-comment)
    (if in-comment
      (if (string-contains? line "*/")
        (multiple-values (substring line (string-index line "*/" #f))
                         #f)
        (values "" #t)
      )
      (let loop ((pos 0))
        (cond
          ((>= pos (string-length line)) (values "" #f))
          ((string-prefix? "//" (substring line pos))
           (values (substring line 0 pos) #f))
          ((string-prefix? "/*" (substring line pos))
           (let-values (((_ in-comment) (process-line (substring line (+ pos 2)) #t)))
             (values (substring line 0 pos) in-comment)))
          (else (loop (+ pos 1)))))))

  (define (process-source lines)
    (define (loop remaining in-comment acc)
      (match remaining
        [(list) (reverse acc)]
        [(line . rest)
         (let-values (((processed in-comment-new) (process-line line in-comment)))
           (loop rest in-comment-new (if (string-empty? processed) acc (cons processed acc))))]))
    (loop lines #f '()))

  (define processed-lines (process-source source))
  (filter (lambda (line) (not (string-empty? line))) processed-lines))

(remove-comments '("a/*comment", "line", "more_comment*/b"))