(define/contract (k-increasing arr k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define n (length arr))
  (define total 0)
  (for ([i (in-range k)])
    (define sublist
      (for/list ([j (in-range i n k)])
        (list-ref arr j)))
    (define len (length sublist))
    (define dp (make-vector len +inf.0))
    (for ([num (in-list sublist)]
          [idx (in-naturals)])
      (define pos (bisect-right dp num 0 len))
      (when (< pos len)
        (vector-set! dp pos num)))
    (define lis-length (bisect-right dp +inf.0 0 len))
    (set! total (+ total (- len lis-length))))
  total)

(define (bisect-right arr target left right)
  (let loop ([left left]
             [right right])
    (if (< left right)
        (let* ([mid (quotient (+ left right) 2)]
               [mid-val (vector-ref arr mid)])
          (if (<= mid-val target)
              (loop (add1 mid) right)
              (loop left mid)))
        left)))