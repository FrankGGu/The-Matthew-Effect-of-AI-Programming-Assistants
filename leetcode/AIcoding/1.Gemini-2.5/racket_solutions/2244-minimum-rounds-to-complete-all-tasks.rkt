(require racket/hash)
(require racket/list)

(define (minimum-rounds tasks)
  (define counts (make-hash))

  (for-each (lambda (task)
              (hash-update! counts task add1 0))
            tasks)

  (define count-values (hash-values counts))

  (if (any (lambda (c) (= c 1)) count-values)
      -1
      (for/sum ([count count-values])
        (quotient (+ count 2) 3))))