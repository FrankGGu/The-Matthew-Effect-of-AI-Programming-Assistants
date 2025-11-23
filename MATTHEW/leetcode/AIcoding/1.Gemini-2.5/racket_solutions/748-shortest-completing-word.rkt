(define (shortest-completing-word licensePlate words)
  (define (completes? plate-counts word-counts)
    (let loop ((keys (hash-keys plate-counts)))
      (if (null? keys)
          #t
          (let* ((char (car keys))
                 (required-count (hash-ref plate-counts char)))
            (if (< (hash-ref word-counts char 0) required-count)
                #f
                (loop (cdr keys)))))))

  (define plate-char-counts
    (let ([counts (make-hash)])
      (for ([c (string->list (string-downcase licensePlate))])
        (when (char-alphabetic? c)
          (hash-set! counts c (+ (hash-ref counts c 0) 1))))
      counts))

  (define min-len +inf.0)
  (define result-word "")

  (for ([word words])
    (define word-char-counts
      (let ([counts (make-hash)])
        (for ([c (string->list word)])
          (hash-set! counts c (+ (hash-ref counts c 0) 1)))
        counts))

    (when (completes? plate-char-counts word-char-counts)
      (let ([current-len (string-length word)])
        (when (< current-len min-len)
          (set! min-len current-len)
          (set! result-word word)))))

  result-word)