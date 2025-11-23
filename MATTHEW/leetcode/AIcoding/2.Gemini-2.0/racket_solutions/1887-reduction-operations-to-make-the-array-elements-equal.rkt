(define (reduction-operations nums)
  (let* ((n (length nums))
         (sorted-nums (sort nums <))
         (unique-nums (remove-duplicates sorted-nums))
         (m (length unique-nums))
         (freq (make-vector m 0)))
    (for ([i (in-range n)])
      (let ([idx (index-of unique-nums (list-ref sorted-nums i))])
        (vector-set! freq idx (+ (vector-ref freq idx) 1))))
    (let loop ([i (- m 1)]
               [ops 0])
      (if (= i 0)
          ops
          (loop (- i 1) (+ ops (* (vector-ref freq i) (- m i 1))))))))

(define (index-of lst x)
  (let loop ([i 0]
             [l lst])
    (cond
      [(empty? l) #f]
      [(= (car l) x) i]
      [else (loop (+ i 1) (cdr l))])))