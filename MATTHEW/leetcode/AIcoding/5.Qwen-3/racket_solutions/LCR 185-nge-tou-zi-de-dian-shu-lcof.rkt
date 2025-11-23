#lang racket

(define (top-k-frequent nums k)
  (define freq (make-hash))
  (for ([n nums])
    (hash-set! freq n (+ 1 (hash-ref freq n 0))))
  (define sorted (sort (hash->list freq) (lambda (a b) (> (cdr a) (cdr b)))))
  (take (map car sorted) k))

(define (probabilities nums k)
  (define freq (make-hash))
  (for ([n nums])
    (hash-set! freq n (+ 1 (hash-ref freq n 0))))
  (define total (length nums))
  (define sorted (sort (hash->list freq) (lambda (a b) (> (cdr a) (cdr b)))))
  (map (lambda (x) (/ (cdr x) total)) (take sorted k)))

(define (main)
  (define input (read-line))
  (define k (string->number (read-line)))
  (define nums (map string->number (string-split input)))
  (define result (probabilities nums k))
  (for ([r result])
    (printf "~a " r))
  (newline))

(main)