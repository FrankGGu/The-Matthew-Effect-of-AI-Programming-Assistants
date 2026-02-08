(define (removeDuplicates nums)
  (if (null? nums)
      0
      (begin
        (define count 1)
        (define n (length nums))
        (for ((i (in-range 1 n)))
          (when (not (= (list-ref nums i) (list-ref nums (- i 1))))
            (begin
              (list-set! nums count (list-ref nums i))
              (set! count (+ count 1)))))
        count)))

(define nums (vector 1 1 2))
(removeDuplicates nums)