#lang racket

(define (smallest-subsequence s)
  (let* ([chars (string->list s)]
         [counts (make-hash)]
         [seen (make-hash)])

    (for-each (lambda (c)
                (hash-set! counts c (+ (hash-ref counts c 0) 1)))
              chars)

    (let loop ([remaining-chars chars]
               [result-stack '()])

      (if (empty? remaining-chars)
          (list->string (reverse result-stack))
          (let* ([current-char (car remaining-chars)]
                 [rest-chars (cdr remaining-chars)])

            (hash-set! counts current-char (- (hash-ref counts current-char) 1))

            (if (hash-has-key? seen current-char)
                (loop rest-chars result-stack)
                (let process-current-char ([current-result-stack result-stack])
                  (if (and (not (empty? current-result-stack))
                           (char<? current-char (car current-result-stack))
                           (> (hash-ref counts (car current-result-stack) 0) 0))
                      (begin
                        (hash-remove! seen (car current-result-stack))
                        (process-current-char (cdr current-result-stack)))
                      (begin
                        (hash-set! seen current-char #t)
                        (loop rest-chars (cons current-char current-result-stack)))))))))))