(define (can-construct s1 s2 target)
  (define (count-chars s)
    (foldl (lambda (char counts)
             (hash-set! counts char (+ 1 (hash-ref counts char 0)))
             counts)
           (hash) s))

  (define counts1 (count-chars s1))
  (define counts2 (count-chars s2))

  (define counts-target (count-chars target))

  (for/fold ([possible #t]) ([char (hash-keys counts-target)])
    (if (not possible)
        #f
        (let ([needed (hash-ref counts-target char 0)]
              [available (+ (hash-ref counts1 char 0) (hash-ref counts2 char 0))])
          (if (>= available needed)
              possible
              #f))))
)

(define (check-if-original-string-exists s1 s2 target)
  (can-construct s1 s2 target))