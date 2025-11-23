(define (rearrange-array nums)
  (let* ([positives (filter (lambda (x) (> x 0)) nums)]
         [negatives (filter (lambda (x) (< x 0)) nums)]
         [len-half (/ (length nums) 2)])
    (let loop ([i 0]
               [pos-current positives]
               [neg-current negatives]
               [result '()])
      (if (= i len-half)
          (reverse result)
          (loop (+ i 1)
                (cdr pos-current)
                (cdr neg-current)
                (cons (car neg-current) (cons (car pos-current) result)))))))