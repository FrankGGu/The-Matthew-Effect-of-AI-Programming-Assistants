#lang racket

(require racket/hash)
(require racket/set)

(define (remove-duplicate-letters s)
  (define n (string-length s))
  (define chars (string->list s))

  (define last-occurrence (make-hash))
  (for ([i (in-range n)]
        [char chars])
    (hash-set! last-occurrence char i))

  (define-values (final-stack final-in-stack)
    (for/fold ([result-stack '()]
               [in-stack (make-hash-set)])
              ([i (in-range n)]
               [char chars])
      (if (hash-set-contains? in-stack char)
          (values result-stack in-stack)
          (let loop ([current-stack result-stack]
                     [current-in-stack in-stack])
            (if (and (not (empty? current-stack))
                     (char<? char (car current-stack))
                     (> (hash-ref last-occurrence (car current-stack)) i))
                (loop (cdr current-stack)
                      (hash-set-remove current-in-stack (car current-stack)))
                (values (cons char current-stack)
                        (hash-set-add current-in-stack char)))))))

  (list->string (reverse final-stack)))