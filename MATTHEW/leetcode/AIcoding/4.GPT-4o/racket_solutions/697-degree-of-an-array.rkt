(define (findShortestSubarray nums)
  (define count (make-hash))
  (define left (make-hash))
  (define right (make-hash))

  (for ([i (in-range (length nums))])
    (hash-set! count (list-ref nums i) (+ 1 (hash-ref count (list-ref nums i) 0)))
    (if (not (hash-has-key? left (list-ref nums i)))
        (hash-set! left (list-ref nums i) i))
    (hash-set! right (list-ref nums i) i))

  (define degree (apply max (hash-values count)))
  (define min-length (define max-int 1+ (length nums)))

  (for ([key (hash-keys count)])
    (when (= (hash-ref count key) degree)
      (define length (+ 1 (- (hash-ref right key) (hash-ref left key))))
      (set! min-length (min min-length length))))

  min-length)