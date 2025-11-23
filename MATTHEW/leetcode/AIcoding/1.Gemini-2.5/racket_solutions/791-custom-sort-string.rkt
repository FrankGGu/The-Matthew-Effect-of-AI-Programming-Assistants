#lang racket

(define (custom-sort-string order s)
  (define char-counts (make-hash))

  (for-each (lambda (c)
              (hash-set! char-counts c (add1 (hash-ref char-counts c 0))))
            (string->list s))

  (define result-chars-rev '())

  (for-each (lambda (c)
              (let ((count (hash-ref char-counts c 0)))
                (for ([_ (in-range count)])
                  (set! result-chars-rev (cons c result-chars-rev)))
                (hash-set! char-counts c 0)))
            (string->list order))

  (hash-for-each (lambda (c count)
                   (for ([_ (in-range count)])
                     (set! result-chars-rev (cons c result-chars-rev))))
                 char-counts)

  (list->string (reverse result-chars-rev)))