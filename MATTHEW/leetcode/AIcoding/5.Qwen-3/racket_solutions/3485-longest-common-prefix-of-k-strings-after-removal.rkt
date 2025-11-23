#lang racket

(define (longest-common-prefix-of-k-strings-after-removal k strings)
  (define (common-prefix s1 s2)
    (define len (min (string-length s1) (string-length s2)))
    (let loop ([i 0])
      (if (= i len)
          (substring s1 0 i)
          (if (char=? (string-ref s1 i) (string-ref s2 i))
              (loop (+ i 1))
              (substring s1 0 i)))))

  (define (reduce prefix str)
    (common-prefix prefix str))

  (if (null? strings)
      ""
      (let ([prefix (car strings)])
        (for/fold ([current-prefix prefix]) ([str (cdr strings)])
          (reduce current-prefix str)))))

(define (main)
  (define input (read-line))
  (define k (string->number input))
  (define strings (for/list ([i k]) (read-line)))
  (displayln (longest-common-prefix-of-k-strings-after-removal k strings)))

(main)