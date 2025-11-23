(define (three-sum nums)
  (define n (length nums))
  (define sorted-nums (sort nums <))
  (define result (list))
  (for ([i (in-range (- n 2))])
    (when (and (> i 0) (= (list-ref sorted-nums i) (list-ref sorted-nums (- i 1))))
      (continue))
    (define left (+ i 1))
    (define right (- n 1))
    (while (< left right)
      (define sum (+ (list-ref sorted-nums i) (list-ref sorted-nums left) (list-ref sorted-nums right)))
      (cond
        [(< sum 0) (set! left (+ left 1))]
        [(> sum 0) (set! right (- right 1))]
        [else
         (set! result (cons (list (list-ref sorted-nums i) (list-ref sorted-nums left) (list-ref sorted-nums right)) result))
         (begin
           (set! left (+ left 1))
           (set! right (- right 1))
           (while (and (< left right) (= (list-ref sorted-nums left) (list-ref sorted-nums (- left 1))))
             (set! left (+ left 1)))
           (while (and (< left right) (= (list-ref sorted-nums right) (list-ref sorted-nums (+ right 1))))
             (set! right (- right 1))))])))
  (reverse result))