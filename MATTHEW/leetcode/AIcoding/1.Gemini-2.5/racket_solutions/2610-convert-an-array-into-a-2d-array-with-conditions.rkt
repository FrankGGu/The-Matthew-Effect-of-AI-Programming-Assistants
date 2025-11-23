(define (find-matrix nums)
  (define freq-map (make-hash))
  (for-each (lambda (num)
              (hash-set! freq-map num (+ (hash-ref freq-map num 0) 1)))
            nums)

  (define max-freq 0)
  (hash-for-each (lambda (num count)
                   (when (> count max-freq)
                     (set! max-freq count)))
                 freq-map)

  (define result-vec (make-vector max-freq '()))

  (hash-for-each (lambda (num count)
                   (for ([i (in-range count)])
                     (vector-set! result-vec i (cons num (vector-ref result-vec i)))))
                 freq-map)

  (vector->list result-vec))