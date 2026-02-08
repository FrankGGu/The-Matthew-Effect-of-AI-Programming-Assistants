(define (countSubstrings s)
  (define n (string-length s))
  (define (dominant? l r)
    (let loop ((i l) (j r) (count 0))
      (cond
        [(= i j) count]
        [(char=? (string-ref s i) #\1)
         (loop (add1 i) j (add1 count))]
        [else
         (loop (add1 i) (sub1 j) count)])))
  (define (count-dominant-substrings)
    (define total 0)
    (for ([length (in-range 1 (+ 1 n))])
      (for ([start (in-range 0 (- n length))])
        (define end (+ start length))
        (if (dominant? start end)
            (set! total (+ total 1)))))
    total)
  (count-dominant-substrings))

(countSubstrings "011001") ; Example test case