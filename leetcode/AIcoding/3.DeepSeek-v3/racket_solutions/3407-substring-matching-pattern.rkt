(define/contract (find-substring s words)
  (-> string? (listof string?) (listof exact-integer?))
  (define word-length (string-length (first words)))
  (define total-length (* word-length (length words)))
  (define word-count (make-hash))
  (define result '())

  (for ([word words])
    (hash-update! word-count word add1 0))

  (for ([i (in-range 0 (+ 1 (- (string-length s) total-length)))])
    (define seen (make-hash))
    (define j 0)
    (define valid #t)

    (while (and valid (< j (length words)))
      (define start (+ i (* j word-length)))
      (define end (+ start word-length))
      (define current-word (substring s start end))

      (if (and (hash-has-key? word-count current-word)
               (< (hash-ref seen current-word 0) (hash-ref word-count current-word)))
          (hash-update! seen current-word add1 0)
          (set! valid #f))

      (set! j (add1 j)))

    (when valid
      (set! result (cons i result))))

  (reverse result))