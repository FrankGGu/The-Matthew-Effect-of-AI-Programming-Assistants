#lang racket

(define/contract (split-message message limit)
  (-> string? exact-positive-integer? (listof string?))
  (define (num-digits n)
    (if (< n 10) 1 (add1 (num-digits (quotient n 10)))))

  (define (try-parts parts)
    (define a (num-digits parts))
    (define total-len (string-length message))
    (define (iter i start len-so-far acc)
      (if (> i parts)
          (reverse acc)
          (let* ([suffix (format "<~a/~a>" i parts)]
                 [suffix-len (string-length suffix)]
                 [max-prefix (- limit suffix-len)]
                 [end (min (+ start max-prefix) total-len)])
            (if (<= end start)
                #f
                (iter (add1 i) end (+ len-so-far (- end start)) 
                      (cons (string-append (substring message start end) suffix) acc))))))
    (iter 1 0 0 '()))

  (let loop ([parts 1])
    (define res (try-parts parts))
    (if res
        res
        (let ([next-parts (add1 parts)])
          (if (> (num-digits next-parts) limit)
              '()
              (loop next-parts))))))