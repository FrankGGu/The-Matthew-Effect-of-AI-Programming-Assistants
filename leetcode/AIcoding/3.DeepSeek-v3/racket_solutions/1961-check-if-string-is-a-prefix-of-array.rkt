(define/contract (is-prefix-string s words)
  (-> string? (listof string?) boolean?)
  (let loop ((i 0) (current-word ""))
    (cond
      [(= i (string-length s)) #t]
      [(string-empty? current-word)
       (if (empty? words)
           #f
           (loop i (first words)))]
      [(>= i (string-length current-word))
       (if (empty? (rest words))
           #f
           (loop i (first (rest words))))]
      [(char=? (string-ref s i) (string-ref current-word i))
       (loop (add1 i) current-word)]
      [else #f])))