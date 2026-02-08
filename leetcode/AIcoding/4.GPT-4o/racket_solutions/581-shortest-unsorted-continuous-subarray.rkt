(define (findUnsortedSubarray nums)
  (define n (length nums))
  (define sorted-nums (sort nums <))

  (define (find-left)
    (for/fold ([i 0]) ([j 0 (sub1 n)])
      (if (not (= (list-ref nums j) (list-ref sorted-nums j)))
          (max i j)
          i)))

  (define (find-right)
    (for/fold ([i n]) ([j (sub1 n) 0])
      (if (not (= (list-ref nums j) (list-ref sorted-nums j)))
          (min i j)
          i)))

  (define left (find-left))
  (define right (find-right))

  (if (>= left right) 0 (- (+ 1 right) left)))