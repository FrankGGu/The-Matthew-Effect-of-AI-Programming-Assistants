(define (numberOfPairs nums)
  (define counts (make-hash))
  (for-each (lambda (x)
              (hash-set! counts x (+ 1 (hash-ref counts x 0))))
            nums)
  (define pairs 0)
  (define leftovers 0)
  (hash-for-each counts
                 (lambda (k v)
                   (set! pairs (+ pairs (quotient v 2)))
                   (set! leftovers (+ leftovers (remainder v 2)))))
  (list pairs leftovers))

(numberOfPairs)