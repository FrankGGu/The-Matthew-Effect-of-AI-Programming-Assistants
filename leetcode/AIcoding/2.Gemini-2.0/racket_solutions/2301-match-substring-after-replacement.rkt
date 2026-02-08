(define (match-substring-after-replacement s sub mappings)
  (define n (string-length s))
  (define m (string-length sub))
  (define mapping-table (make-hash))
  (for ([mapping mappings])
    (hash-set! mapping-table (car mapping) (cdr mapping)))

  (define (can-match start-s start-sub)
    (cond
      [(>= start-sub m) #t]
      [(>= start-s n) #f]
      [(string=? (string (string-ref s start-s)) (string (string-ref sub start-sub)))
       (can-match (+ start-s 1) (+ start-sub 1))]
      [(hash-ref mapping-table (string-ref sub start-sub) #f)
       (if (string=? (string (hash-ref mapping-table (string-ref sub start-sub))) (string (string-ref s start-s)))
           (can-match (+ start-s 1) (+ start-sub 1))
           #f)]
      [else #f]))

  (for/or ([i (in-range 0 (- n m -1))])
    (can-match i 0)))