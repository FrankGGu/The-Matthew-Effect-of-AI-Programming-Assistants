(define (can-rearrange substrings target)
  (define (count-char str)
    (foldl (lambda (c acc)
             (hash-update! acc c (lambda (x) (+ x 1)) 1))
           (make-hash) str))

  (define target-count (count-char target))
  (define substrings-count (foldl (lambda (s acc)
                                     (for-each (lambda (c)
                                                 (hash-update! acc c (lambda (x) (+ x 1)) 0))
                                               s)
                                     acc)
                                   (make-hash) substrings))

  (for/hash ([k (hash-keys target-count)])
    (if (>= (hash-ref substrings-count k 0) (hash-ref target-count k 0))
        k
        #f)))

(define (rearrange-k-substrings substrings target)
  (define substrings-length (length substrings))
  (and (>= substrings-length (string-length target))
       (not (null? (can-rearrange substrings target)))))