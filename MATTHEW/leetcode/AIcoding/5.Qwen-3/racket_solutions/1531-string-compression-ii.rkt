#lang racket

(define (get-length-of-optimal-encoding s k)
  (define memo (make-hash))
  (define (dp i removed)
    (cond [(>= i (string-length s)) 0]
          [(hash-has-key? memo (cons i removed)) (hash-ref memo (cons i removed))]
          [else
           (let ([res (if (= removed k) 0 (add1 (dp i (add1 removed))))])
             (let loop ([j (add1 i)] [count 1] [last-char (string-ref s i)])
               (if (>= j (string-length s))
                   (begin
                     (hash-set! memo (cons i removed) res)
                     res)
                   (let ([current-char (string-ref s j)])
                     (if (char=? current-char last-char)
                         (loop (add1 j) (add1 count) last-char)
                         (let ([new-res (min res (+ (if (> count 1) (string-length (number->string count)) 0) (dp (add1 j) removed)))])
                           (loop (add1 j) 1 current-char)))))))]))
  (dp 0 0))