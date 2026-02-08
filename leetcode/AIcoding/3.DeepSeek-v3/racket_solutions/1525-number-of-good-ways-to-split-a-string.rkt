(define (num-splits s)
  (let* ([n (string-length s)]
         [left (make-hash)]
         [right (make-hash)]
         [count 0])
    (for ([i (in-range n)])
      (hash-update! right (string-ref s i) add1 0))
    (for ([i (in-range n)])
      (hash-update! left (string-ref s i) add1 0)
      (hash-update! right (string-ref s i) sub1 0)
      (when (zero? (hash-ref right (string-ref s i) 0))
        (hash-remove! right (string-ref s i)))
      (when (= (hash-count left) (hash-count right))
        (set! count (add1 count))))
    count))