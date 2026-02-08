(define (minimum-right-shifts nums)
  (define n (length nums))
  (define (is-sorted arr)
    (cond
      [(<= (length arr) 1) #t]
      [else
       (and (<= (first arr) (second arr))
            (is-sorted (rest arr)))]))

  (define (rotate arr k)
    (append (drop-right arr k) (take-right arr k)))

  (cond
    [(is-sorted nums) 0]
    [else
     (let loop ([k 1])
       (cond
         [(> k n) -1]
         [(is-sorted (rotate nums k)) k]
         [else (loop (+ k 1))]))]))