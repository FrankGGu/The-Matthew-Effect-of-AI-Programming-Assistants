(define (smallest-subsequence s)
  (define last-occurrence (make-hash))
  (define seen (make-hash))
  (define stack '())

  (for ([i (in-range (string-length s))])
    (hash-set! last-occurrence (string-ref s i) i))

  (for ([i (in-range (string-length s))])
    (define c (string-ref s i))

    (when (not (hash-has-key? seen c))
      (while (and (not (null? stack))
                  (char<? (car stack) c)
                  (>= (hash-ref last-occurrence (car stack)) i))
        (hash-remove! seen (car stack))
        (set! stack (cdr stack)))

      (set! stack (cons c stack))
      (hash-set! seen c #t)))

  (list->string (reverse stack)))