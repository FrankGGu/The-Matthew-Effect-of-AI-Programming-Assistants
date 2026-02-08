(define (minimum-buckets hamsters)
  (let loop ([hs (string->list hamsters)] [i 0] [buckets 0])
    (cond
      [(null? hs) buckets]
      [(char=? (car hs) #\H)
       (cond
         [(and (> i 0) (char=? (list-ref (string->list hamsters) (- i 1)) #\B))
          (loop (cdr hs) (+ i 1) buckets)]
         [(and (< (sub1 (string-length hamsters)) i) (char=? (list-ref (string->list hamsters) (+ i 1)) #\.) )
          (loop (cdr hs) (+ i 1) (+ buckets 1))]
         [(and (< (sub1 (string-length hamsters)) i) (char=? (list-ref (string->list hamsters) (+ i 1)) #\H))
          -1]
         [(and (< (sub1 (string-length hamsters)) i) (char=? (list-ref (string->list hamsters) (+ i 1)) #\B))
            (loop (cdr hs) (+ i 1) buckets)]
         [(and (= (string-length hamsters) 1)) 
          -1]
         [else -1])]
      [else (loop (cdr hs) (+ i 1) buckets)])))