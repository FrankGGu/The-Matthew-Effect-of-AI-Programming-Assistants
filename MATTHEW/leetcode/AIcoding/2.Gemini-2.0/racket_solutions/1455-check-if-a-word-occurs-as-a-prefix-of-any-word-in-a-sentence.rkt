(define (is-prefix? prefix word)
  (and (>= (string-length word) (string-length prefix))
       (equal? prefix (substring word 0 (string-length prefix)))))

(define (is-prefix-of-word sentence searchWord)
  (let loop ([words (string-split sentence " ")])
    (cond
      [(null? words) -1]
      [(is-prefix? searchWord (car words)) (+ 1 (- (length (takef words (lambda (x) #t)))))]
      [else (loop (cdr words))])))

(provide is-prefix-of-word)