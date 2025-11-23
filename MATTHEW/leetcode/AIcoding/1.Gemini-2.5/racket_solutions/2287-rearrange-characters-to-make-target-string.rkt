(define (get-char-counts str)
  (define counts (make-hash))
  (for ([char (string->list str)])
    (hash-set! counts char (+ (hash-ref counts char 0) 1)))
  counts)

(define (rearrange-characters s target)
  (define s-counts (get-char-counts s))
  (define target-counts (get-char-counts target))

  (define max-possible-copies +inf.0)

  (hash-for-each
   (lambda (char target-count)
     (define s-count (hash-ref s-counts char 0))
     (define possible-copies (floor (/ s-count target-count)))
     (set! max-possible-copies (min max-possible-copies possible-copies)))
   target-counts)

  (exact-floor max-possible-copies))