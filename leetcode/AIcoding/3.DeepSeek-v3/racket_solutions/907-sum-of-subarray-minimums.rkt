(define/contract (sum-subarray-mins arr)
  (-> (listof exact-integer?) exact-integer?)
  (define MOD 1000000007)
  (define n (length arr))
  (define left (make-vector n -1))
  (define right (make-vector n n))
  (define stack '())

  ; Calculate left boundaries
  (for ([i (in-range n)])
    (while (and (not (null? stack)) (<= (list-ref arr (car stack)) (list-ref arr i)))
      (set! stack (cdr stack)))
    (if (not (null? stack))
        (vector-set! left i (car stack))
        (vector-set! left i -1))
    (set! stack (cons i stack)))

  (set! stack '())

  ; Calculate right boundaries
  (for ([i (in-range (- n 1) -1 -1)])
    (while (and (not (null? stack)) (< (list-ref arr (car stack)) (list-ref arr i)))
      (set! stack (cdr stack)))
    (if (not (null? stack))
        (vector-set! right i (car stack))
        (vector-set! right i n))
    (set! stack (cons i stack)))

  ; Calculate the sum
  (define sum 0)
  (for ([i (in-range n)])
    (define l (- i (vector-ref left i)))
    (define r (- (vector-ref right i) i))
    (set! sum (modulo (+ sum (* (list-ref arr i) l r)) MOD))

  sum)