(require racket/control)

(define (is-n-straight-hand hand groupSize)
  (let* ([n (length hand)])
    (unless (= (modulo n groupSize) 0)
      #f)

    (define sorted-hand (sort hand <))

    (define card-counts (make-hash))
    (for-each (lambda (card)
                (hash-set! card-counts card (+ (hash-ref card-counts card 0) 1)))
              sorted-hand)

    (let/ec return-false
      (for ([card sorted-hand])
        (let ([count (hash-ref card-counts card 0)])
          (when (> count 0)
            (for ([i (range groupSize)])
              (let ([current-card (+ card i)])
                (let ([current-count (hash-ref card-counts current-card 0)])
                  (when (zero? current-count)
                    (return-false #f))
                  (hash-set! card-counts current-card (- current-count 1))))))))
      #t)))