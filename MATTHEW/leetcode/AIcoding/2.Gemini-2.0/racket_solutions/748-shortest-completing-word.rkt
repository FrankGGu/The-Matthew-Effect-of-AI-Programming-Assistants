(define (shortest-completing-word licensePlate words)
  (define license-freq (make-hash))
  (for ([c (string->list licensePlate)])
    (let ([lc (char-downcase c)])
      (when (char-alphabetic? lc)
        (hash-update! license-freq lc (lambda (v) (+ v 1)) 1)))))

  (define (completes? word)
    (define word-freq (make-hash))
    (for ([c (string->list word)])
      (let ([lc (char-downcase c)])
        (hash-update! word-freq lc (lambda (v) (+ v 1)) 1)))
    (hash-for-each license-freq
                   (lambda (k v)
                     (when (or (not (hash-has-key? word-freq k))
                               (< (hash-ref word-freq k) v))
                       (return #f))))
    #t)

  (define result #f)
  (for ([word words])
    (when (completes? word)
      (cond
        [(not result) (set! result word)]
        [(< (string-length word) (string-length result)) (set! result word)])))
  result)