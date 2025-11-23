(define (apply-operations nums)
  (let loop ([nums nums] [i 0])
    (cond
      [(>= i (sub1 (length nums))) nums]
      [(= (list-ref nums i) (list-ref nums (+ i 1)))
       (loop (list-set! (list-set! nums i (* 2 (list-ref nums i))) (+ i 1) 0) (+ i 2))]
      [else (loop nums (+ i 1))])))

(define (move-zeroes nums)
  (let loop ([nums nums] [i 0] [j 0])
    (cond
      [(>= i (length nums))
       (let loop2 ([nums nums] [i j])
         (cond
           [(>= i (length nums)) nums]
           [else (loop2 (list-set! nums i 0) (+ i 1))]))]
      [(= (list-ref nums i) 0)
       (loop nums (+ i 1) j)]
      [else
       (if (= i j)
           (loop nums (+ i 1) (+ j 1))
           (loop (list-set! (list-set! nums i (list-ref nums j)) j (list-ref nums i)) (+ i 1) (+ j 1)))])))

(define (apply-operations-and-move-zeroes nums)
  (move-zeroes (apply-operations nums)))

(define (apply-operations-to-array nums)
  (apply-operations-and-move-zeroes nums))