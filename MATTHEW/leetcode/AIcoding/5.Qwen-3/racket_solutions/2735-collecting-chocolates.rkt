#lang racket

(define (min-cost-to-collect-chocolates)
  (define input (file->string "stdin"))
  (define lines (string-split input "\n"))
  (define n (string->number (list-ref lines 0)))
  (define lst (map string->number (string-split (list-ref lines 1))))
  (define freq (make-hash))
  (for-each (lambda (x) (hash-set! freq x (+ 1 (hash-ref freq x 0)))) lst)
  (define keys (hash-keys freq))
  (define sum (apply + lst))
  (define total 0)
  (for-each (lambda (k)
              (set! total (+ total (* k (hash-ref freq k)))))
            keys)
  (if (= total sum) 0 (- sum total)))

(min-cost-to-collect-chocolates)