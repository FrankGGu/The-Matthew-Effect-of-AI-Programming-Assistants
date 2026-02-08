(define (partition-string s)
  (let loop ([i 0] [count 1] [seen '()])
    (cond
      [(>= i (string-length s)) count]
      [(member (string-ref s i) seen)
       (loop (add1 i) (add1 count) (list (string-ref s i)))]
      [else
       (loop (add1 i) count (cons (string-ref s i) seen))])))