#lang racket

(define (max-partitions-after-operations s k)
  (define n (string-length s))
  (define memo (make-hash))

  (define (dp pos changed last-char last-count)
    (if (>= pos n)
        1
        (let ([key (list pos changed last-char last-count)])
          (if (hash-has-key? memo key)
              (hash-ref memo key)
              (let* ([current-char (string-ref s pos)]
                     [new-count (if (equal? current-char last-char) (add1 last-count) 1)]
                     [new-char current-char]
                     [res (if (<= new-count k)
                              (dp (add1 pos) changed new-char new-count)
                              (add1 (dp (add1 pos) changed current-char 1)))]
                     [res (if (zero? changed)
                              (let ([max-res res])
                                (for ([new-c (in-range 26)])
                                  (let* ([c (integer->char (+ (char->integer #\a) new-c))]
                                         [new-count (if (equal? c last-char) (add1 last-count) 1)]
                                         [new-res (if (<= new-count k)
                                                      (dp (add1 pos) 1 c new-count)
                                                      (add1 (dp (add1 pos) 1 c 1)))])
                                    (set! max-res (max max-res new-res))))
                                max-res)
                              res)])
                (hash-set! memo key res)
                res)))))

  (dp 0 0 #\nul 0))