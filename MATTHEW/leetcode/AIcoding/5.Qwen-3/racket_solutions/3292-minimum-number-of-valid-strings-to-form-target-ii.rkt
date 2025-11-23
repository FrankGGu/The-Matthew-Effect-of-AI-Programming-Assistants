#lang racket

(define (min-number-of-strings-ii words target)
  (define dp (make-hash))
  (define (dfs i)
    (hash-ref dp i #f))
  (define (helper i)
    (cond [(= i (string-length target)) 0]
          [(not (hash-has-key? dp i)) 
           (let ([res (if (= i (string-length target)) 0 
                          (for/fold ([min-val +inf.0]) ([word words])
                            (if (and (<= (+ i (string-length word)) (string-length target))
                                     (equal? (substring target i (+ i (string-length word))) word))
                                (min min-val (add1 (helper (+ i (string-length word)))))
                                min-val)))]
             (hash-set! dp i res)
             res)]
          [else (hash-ref dp i)]))
  (helper 0))