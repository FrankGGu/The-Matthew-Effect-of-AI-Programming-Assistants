(define/contract (number-of-subarrays nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define (at-most k)
    (let loop ([left 0] [right 0] [count 0] [result 0])
      (if (>= right (length nums))
          result
          (let* ([num (list-ref nums right)]
                 [new-count (if (odd? num) (+ count 1) count)])
            (if (> new-count k)
                (loop (+ left 1) right (- count (if (odd? (list-ref nums left)) 1 0))) (- result (- right left)))
                (loop left (+ right 1) new-count (+ result (- right left 1))))))))
  (- (at-most k) (at-most (- k 1))))