(define (maxConsecutive floors special)
  (define sorted-special (sort special <))
  (define n (length sorted-special))

  (define (helper i max-diff)
    (cond
      [(= i n)
       (max max-diff (- floors (car (last sorted-special))))]
      [(zero? i)
       (helper (+ i 1) (- (car sorted-special) 1))]
      [else
       (helper (+ i 1) (max max-diff (- (list-ref sorted-special i) (list-ref sorted-special (- i 1)) 1)))]))

  (helper 0 0))