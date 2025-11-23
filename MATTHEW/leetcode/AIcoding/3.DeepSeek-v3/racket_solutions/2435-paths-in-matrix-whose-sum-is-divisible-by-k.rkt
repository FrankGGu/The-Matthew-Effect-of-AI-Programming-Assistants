(define/contract (number-of-paths grid k)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (define m (length grid))
  (define n (if (null? grid) 0 (length (car grid))))
  (define mod 1000000007)

  (define dp (make-vector m (make-vector n (make-hash))))

  (define (helper i j sum)
    (cond
      [(or (>= i m) (>= j n)) 0]
      [(and (= i (sub1 m)) (= j (sub1 n)))
       (if (zero? (modulo (+ sum (list-ref (list-ref grid i) j)) k)) 1 0)]
      [else
       (define current (list-ref (list-ref grid i) j))
       (define new-sum (+ sum current))
       (define key (modulo new-sum k))
       (hash-ref! (vector-ref (vector-ref dp i) j) key
                  (λ ()
                    (modulo (+ (helper (add1 i) j new-sum)
                             (helper i (add1 j) new-sum))
                           mod)))]))

  (helper 0 0 0))