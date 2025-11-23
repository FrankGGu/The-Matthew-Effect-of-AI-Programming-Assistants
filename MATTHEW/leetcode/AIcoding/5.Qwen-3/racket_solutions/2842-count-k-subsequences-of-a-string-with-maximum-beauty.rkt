#lang racket

(define (count-k-subsequences s k)
  (define n (string-length s))
  (define freq (make-hash))
  (for ([c (in-string s)])
    (hash-set! freq c (+ 1 (hash-ref freq c 0))))
  (define sorted-freq (sort (hash->list freq) (lambda (a b) (> (cdr a) (cdr b)))))
  (define max-beauty (apply + (map cdr (take sorted-freq k))))
  (define count (for/fold ([res 1]) ([i (in-range k)])
                  (* res (hash-ref freq (caar (drop sorted-freq i))))))
  count)