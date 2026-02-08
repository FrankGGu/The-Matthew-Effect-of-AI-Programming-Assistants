(define (is-ancestor a b)
  (cond [(equal? a b) #t]
        [(equal? a '朝代1) (or (equal? b '朝代2) (equal? b '朝代3))]
        [(equal? a '朝代2) (equal? b '朝代3)]
        [(equal? a '朝代3) #f]
        [else #f]))

(define (check-dynasties a b)
  (if (is-ancestor a b)
      "YES"
      "NO"))