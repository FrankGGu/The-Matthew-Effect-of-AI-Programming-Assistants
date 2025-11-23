(define (maximum-removals s p removable)
  (define (binary-search left right)
    (if (> left right)
        left
        (let* ([mid (quotient (+ left right) 2)]
               [removed (list->set (take removable mid))]
          (if (is-subsequence? s p removed)
              (binary-search (add1 mid) right)
              (binary-search left (sub1 mid))))))

  (define (is-subsequence? s p removed)
    (let loop ([i 0] [j 0])
      (cond
        [(= j (string-length p)) #t]
        [(>= i (string-length s)) #f]
        [(set-member? removed i) (loop (add1 i) j)]
        [(char=? (string-ref s i) (string-ref p j)) (loop (add1 i) (add1 j))]
        [else (loop (add1 i) j)])))

  (sub1 (binary-search 0 (length removable))))