(define/contract (len-longest-fib-subseq arr)
  (-> (listof exact-integer?) exact-integer?)
  (let ([n (length arr)]
        [indices (make-hash)]
        [dp (make-hash)]
        [max-len 0])
    (for ([(val i) (in-indexed arr)])
      (hash-set! indices val i))
    (for ([k (in-range n)])
      (for ([j (in-range k)])
        (let ([diff (- (list-ref arr k) (list-ref arr j))]))
          (when (and (< diff (list-ref arr j))
                     (hash-has-key? indices diff))
            (let ([i (hash-ref indices diff)])
              (hash-set! dp (cons j k) (+ 1 (hash-ref dp (cons i j) 2)))
              (set! max-len (max max-len (hash-ref dp (cons j k))))))))
    (if (>= max-len 3) max-len 0)))