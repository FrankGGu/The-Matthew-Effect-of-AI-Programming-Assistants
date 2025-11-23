#lang racket

(define (restore-ip-addresses s)
  (define (is-valid? part)
    (and (not (equal? "" part))
         (or (<= (string-length part) 3)
             (and (char=? #\0 (string-ref part 0)) (= (string-length part) 1)))
         (<= (string->number part) 255)))

  (define (backtrack start parts result)
    (cond [(= (length parts) 4)
           (if (= (length s) start)
               (set! result (cons (string-join parts ".") result))
               #f)]
          [else
           (for ([i (in-range (add1 start) (min (+ start 4) (add1 (string-length s))))])
             (define part (substring s start i))
             (when (is-valid? part)
               (backtrack i (append parts (list part)) result)))]))

  (let ([result '()])
    (backtrack 0 '() result)
    (reverse result)))