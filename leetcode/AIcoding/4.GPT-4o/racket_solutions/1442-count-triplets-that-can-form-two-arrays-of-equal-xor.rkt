(define (countTriplets arr)
  (define n (length arr))
  (define (xor-sum lst)
    (foldl (lambda (x y) (bit-xor x y)) 0 lst))
  (define (count)
    (for*/list ([i (in-range n)]
                 [j (in-range n)]
                 [k (in-range n)])
      (when (and (not (= i j)) (not (= j k)) (not (= k i)))
        (if (= (xor-sum (list-ref arr i)) (xor-sum (list-ref arr j)))
            1
            0))))
  (define result (foldl + 0 (count)))
  (* result 3))

(countTriplets (list 2 3 1))