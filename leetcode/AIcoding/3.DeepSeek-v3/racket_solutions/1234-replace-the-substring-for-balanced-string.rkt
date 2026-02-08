(define/contract (balanced-string s)
  (-> string? exact-integer?)
  (let* ([n (string-length s)]
         [target (/ n 4)]
         [count (make-hash)]
         [left 0]
         [result n])
    (for ([i (in-range n)])
      (hash-update! count (string-ref s i) add1 0))
    (when (and (= (hash-ref count #\Q 0) target)
               (= (hash-ref count #\W 0) target)
               (= (hash-ref count #\E 0) target)
          (= (hash-ref count #\R 0) target))
      (return 0))
    (for ([right (in-range n)])
      (hash-update! count (string-ref s right) sub1)
      (while (and (<= (hash-ref count #\Q 0) target)
                  (<= (hash-ref count #\W 0) target)
                  (<= (hash-ref count #\E 0) target)
                  (<= (hash-ref count #\R 0) target))
        (set! result (min result (- right left -1)))
        (hash-update! count (string-ref s left) add1)
        (set! left (add1 left))))
    result))