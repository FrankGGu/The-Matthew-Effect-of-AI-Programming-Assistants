#lang racket

(define (max-happy-groups batchSize groups)
  (define freq (make-hash))
  (define remainder0 0)

  (for ([g groups])
    (define r (modulo g batchSize))
    (if (zero? r)
        (set! remainder0 (add1 remainder0))
        (hash-update! freq r add1 0)))

  (define memo (make-hash))

  (define (dfs state)
    (if (hash-has-key? memo state)
        (hash-ref memo state)
        (let ([res 0])
          (for ([(r cnt) (in-hash freq)])
            (when (positive? cnt)
              (hash-update! freq r sub1)
              (define new-state (state-update state r batchSize))
              (set! res (max res (dfs new-state)))
              (hash-update! freq r add1)))
          (hash-set! memo state (if (zero? res) 0 (add1 res)))
          (hash-ref memo state))))

  (define (state-update state r batchSize)
    (for/fold ([new-state 0] [power 1] #:result new-state)
              ([i (in-range batchSize)])
      (define rem (modulo (- i r) batchSize))
      (define cnt (bitwise-and (arithmetic-shift state (- (* i 5))) 31))
      (values (+ new-state (* cnt power)) (* power 32))))

  (+ remainder0 (dfs 0)))