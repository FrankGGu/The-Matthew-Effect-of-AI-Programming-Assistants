(define/contract (min-operations target arr)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let* ([target-pos (make-hash)]
         [n (length target)]
         [m (length arr)]
         [lis (list)])
    (for ([num target]
          [i (in-range n)])
      (hash-set! target-pos num i))
    (for ([num arr]
          [i (in-range m)])
      (when (hash-has-key? target-pos num)
        (let ([pos (hash-ref target-pos num)])
          (if (null? lis)
              (set! lis (list pos))
              (let ([left 0]
                    [right (sub1 (length lis))])
                (while (<= left right)
                  (let ([mid (quotient (+ left right) 2)])
                    (if (< (list-ref lis mid) pos)
                        (set! left (add1 mid))
                        (set! right (sub1 mid)))))
                (if (= left (length lis))
                    (set! lis (append lis (list pos)))
                    (set! lis (list-set lis left pos)))))))
    (- n (if (null? lis) 0 (length lis)))))