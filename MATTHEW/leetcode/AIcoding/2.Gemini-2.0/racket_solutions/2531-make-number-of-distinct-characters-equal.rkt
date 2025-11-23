(define (make-equal s t)
  (define (count-chars str)
    (define char-counts (make-hash))
    (for ([c (string->list str)])
      (hash-update! char-counts c (lambda (v) (+ v 1)) 1))
    char-counts)

  (define s-counts (count-chars s))
  (define t-counts (count-chars t))

  (define s-distinct-count (hash-count s-counts))
  (define t-distinct-count (hash-count t-counts))

  (define (check-swap s-char t-char)
    (define new-s-counts (hash-copy s-counts))
    (define new-t-counts (hash-copy t-counts))

    (hash-update! new-s-counts s-char (lambda (v) (- v 1)) 0)
    (when (= (hash-ref new-s-counts s-char) 0)
      (hash-remove! new-s-counts s-char))

    (hash-update! new-s-counts t-char (lambda (v) (+ v 1)) 1)

    (hash-update! new-t-counts t-char (lambda (v) (- v 1)) 0)
    (when (= (hash-ref new-t-counts t-char) 0)
      (hash-remove! new-t-counts t-char))

    (hash-update! new-t-counts s-char (lambda (v) (+ v 1)) 1)

    (= (hash-count new-s-counts) (hash-count new-t-counts)))

  (for* ([s-char (in-list (hash-keys s-counts))]
         [t-char (in-list (hash-keys t-counts))])
    (when (check-swap s-char t-char)
      (return #t)))

  #f)