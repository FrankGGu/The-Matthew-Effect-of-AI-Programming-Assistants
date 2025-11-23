(define/contract (longest-beautiful-substring word)
  (-> string? exact-integer?)
  (define vowels '(#\a #\e #\i #\o #\u))
  (define n (string-length word))
  (define max-len 0)
  (define (helper start)
    (if (>= start n)
        max-len
        (let loop ([i start] [j 0] [count 0] [current-start start])
          (cond
            [(>= i n)
             (if (and (= j 5) (> count max-len))
                 count
                 (helper (add1 current-start)))]
            [(< j 5)
             (if (char=? (string-ref word i) (list-ref vowels j))
                 (loop (add1 i) j (add1 count) current-start)
                 (if (and (< (add1 j) 5) (char=? (string-ref word i) (list-ref vowels (add1 j))))
                     (loop (add1 i) (add1 j) (add1 count) current-start)
                     (helper (add1 current-start))))]
            [else
             (if (char=? (string-ref word i) #\u)
                 (loop (add1 i) j (add1 count) current-start)
                 (begin
                   (when (> count max-len)
                     (set! max-len count))
                   (helper (add1 current-start))))]))))
  (helper 0)
  max-len)