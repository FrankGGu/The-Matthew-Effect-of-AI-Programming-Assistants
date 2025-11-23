#lang racket

(define (max-employees-to-invite head)
  (define visited (make-hash))
  (define (dfs node)
    (cond [(hash-has-key? visited node) (hash-ref visited node)]
          [else
           (hash-set! visited node #f)
           (let ([next (vector-ref head node)])
             (if (hash-has-key? visited next)
                 (if (equal? (hash-ref visited next) #f)
                     (begin
                       (hash-set! visited node #t)
                       1)
                     0)
                 (let ([res (dfs next)])
                   (if (equal? res 0)
                       0
                       (begin
                         (hash-set! visited node #t)
                         (+ res 1))))))]))

  (define result 0)
  (for ([i (in-range (vector-length head))])
    (when (not (hash-has-key? visited i))
      (set! result (+ result (dfs i)))))
  result)