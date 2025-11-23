(define (min-pair-removal nums)
  (define (count-frequencies lst)
    (foldl (lambda (x acc) (if (hash-has-key? acc x)
                                (hash-set! acc x (+ (hash-ref acc x) 1))
                                (hash-set! acc x 1)))
           (make-hash)
           lst))

  (define freqs (count-frequencies nums))
  (define odd-count (hash-count (lambda (k v) (odd? v)) freqs))
  odd-count)

(min-pair-removal '(1 3 2 1 3 2 2))