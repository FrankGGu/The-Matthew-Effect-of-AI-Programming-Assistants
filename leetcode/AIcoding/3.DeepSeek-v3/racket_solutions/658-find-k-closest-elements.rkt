(define/contract (find-closest-elements arr k x)
  (-> (listof exact-integer?) exact-integer? exact-integer? (listof exact-integer?))
  (let* ([n (length arr)]
         [left 0]
         [right (- n k)])
    (let loop ([left left] [right right])
      (if (< left right)
          (let* ([mid (quotient (+ left right) 2)]
                 [diff-left (- (list-ref arr mid) x)]
                 [diff-right (- (list-ref arr (+ mid k)) x)])
            (if (< diff-right diff-left)
                (loop (add1 mid) right)
                (loop left mid)))
          (take (drop arr left) k)))))