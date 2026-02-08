(define (zero-array-transformation-ii nums)
  (let loop ((nums nums) (ops 0))
    (cond
      [(empty? nums) ops]
      [(apply = nums)
       (if (= (car nums) 0)
           ops
           -1)]
      [else
       (let* ((n (length nums))
              (i (for/first ((i (in-range n)) #:when (> (list-ref nums i) 0)) i))
              (j (for/first ((j (in-range i n)) #:when (<= (list-ref nums j) 0)) j)))
         (if (or (null? i) (null? j))
             -1
             (loop (let loop2 ((nums nums) (idx 0))
                     (cond
                       [(= idx i)
                        (cons (- (car nums)) (loop2 (cdr nums) (+ idx 1)))]
                       [(empty? nums) '()]
                       [else
                        (cons (car nums) (loop2 (cdr nums) (+ idx 1)))]))
                   (+ ops 1))))])))