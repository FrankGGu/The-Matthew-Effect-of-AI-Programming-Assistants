(define/contract (count-bad-pairs nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ([n (length nums)]
        [count 0]
        [ht (make-hash)])
    (for ([i (in-range n)])
      (let* ([num (list-ref nums i)]
             [key (- num i)]
             [val (hash-ref ht key 0)])
        (set! count (+ count val))
        (hash-set! ht key (add1 val))))
    (- (* n (sub1 n)) (* 2 count))))