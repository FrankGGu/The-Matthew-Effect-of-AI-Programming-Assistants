#lang racket

(define (longest-palindrome words)
  (define counts (make-hash))
  (for-each (lambda (word) (hash-update! counts word add1)) words)
  (define (reverse-word word)
    (list->string (reverse (string->list word))))
  (define (is-palindrome? word)
    (equal? word (reverse-word word)))
  (define (can-pair? a b)
    (and (not (equal? a b)) (equal? (reverse-word a) b)))
  (define (count-pairs)
    (let loop ([words (hash-keys counts)] [pairs 0])
      (if (null? words)
          pairs
          (let* ([word (car words)]
                 [other (reverse-word word)]
                 [count (hash-ref counts word)])
            (if (and (not (equal? word other)) (hash-has-key? counts other))
                (loop (cdr words) (+ pairs (min count (hash-ref counts other))))
                (loop (cdr words) pairs)))))
  (define (has-single?)
    (for/first ([word (in-hash-keys counts)] #:when (is-palindrome? word)) #t))
  (let* ([pairs (count-pairs)]
         [single (if (has-single?) 1 0)])
    (* 2 (+ pairs single))))