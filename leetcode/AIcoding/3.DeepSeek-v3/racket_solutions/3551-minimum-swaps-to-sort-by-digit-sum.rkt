(define/contract (minimum-swaps nums)
  (-> (listof exact-integer?) exact-integer?)
  (define (digit-sum n)
    (let loop ([n (abs n)] [sum 0])
      (if (zero? n)
          sum
          (loop (quotient n 10) (+ sum (remainder n 10))))))

  (define indexed-nums (map cons nums (range (length nums))))
  (define sorted (sort indexed-nums < #:key (lambda (x) (digit-sum (car x)))))

  (define visited (make-vector (length nums) #f))
  (define swaps 0)

  (for ([i (in-range (length nums))])
    (unless (vector-ref visited i)
      (let loop ([j i] [cycle-size 0])
        (if (vector-ref visited j)
            (set! swaps (+ swaps (- cycle-size 1)))
            (begin
              (vector-set! visited j #t)
              (loop (cdr (list-ref sorted j)) (+ cycle-size 1)))))))

  swaps)