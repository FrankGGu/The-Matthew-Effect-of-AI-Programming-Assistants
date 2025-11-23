(define (repeated-string-match a b)
  (let loop ((a a)
             (count 1)
             (max-count (+ (quotient (string-length b) (string-length a)) 2)))
    (cond
      [(> count max-count) -1]
      [(string-contains? a b) count]
      [else (loop (string-append a (car (string->list a))) (add1 count) max-count)])))