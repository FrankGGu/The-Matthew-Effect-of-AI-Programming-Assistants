(define (minDeletions A B)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (mod a b))))

  (define (lcm a b)
    (/ (* a b) (gcd a b)))

  (define sorted-A (sort A <))
  (define sorted-B (sort B <))

  (define (count-deletions a b)
    (define n (length a))
    (define m (length b))
    (define (loop i j deletions)
      (cond
        [(= i n) deletions]
        [(= j m) (+ deletions (- n i))]
        [(<= (lcm (list-ref a i) (list-ref b j)) (list-ref b j))
         (loop (add1 i) j deletions)
         ]
        [else
         (loop i (add1 j) deletions)
        ]))
    (loop 0 0 0))

  (count-deletions sorted-A sorted-B))

(define (minDeletionsMain A B)
  (minDeletions A B))