#lang racket

(define (count-mentions tweets)
  (define mentions (make-hash))
  (for ([tweet (in-list tweets)])
    (define words (string-split tweet))
    (for ([word (in-list words)])
      (when (and (> (string-length word) 1) (char=? (string-ref word 0) #\@))
        (define username (substring word 1))
        (hash-update! mentions username (lambda (x) (+ x 1)) 0)))
  (hash->list mentions))