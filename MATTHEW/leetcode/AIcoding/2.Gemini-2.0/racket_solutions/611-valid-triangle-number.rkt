(define (valid-triangle-number nums)
  (define sorted-nums (sort nums <))
  (define (count-valid i)
    (define (helper left right count)
      (cond
        [(>= left right) count]
        [(> (+ (list-ref sorted-nums left) (list-ref sorted-nums right)) (list-ref sorted-nums i))
         (helper left (- right 1) (+ count (- right left)))]
        [else
         (helper (+ left 1) right count)]))
    (helper 0 (- i 1) 0))
  (define (main-loop i count)
    (cond
      [(< i 2) count]
      [else (main-loop (- i 1) (+ count (count-valid i)))]))
  (main-loop (- (length sorted-nums) 1) 0))