(define (min-absolute-sum-difference nums1 nums2)
  (define n (length nums1))
  (define sorted-nums1 (sort nums1 <))
  (define (abs-diff x y) (abs (- x y)))
  (define (find-closest num)
    (let loop ([left 0] [right (- n 1)])
      (cond
        [(>= left right)
         (let ([lower (list-ref sorted-nums1 left)]
               [upper (if (< right n) (list-ref sorted-nums1 right) +inf.0)])
           (if (< (abs-diff num lower) (abs-diff num upper))
               lower
               upper))]
        [else
         (let ([mid (quotient (+ left right) 2)]
               [mid-val (list-ref sorted-nums1 mid)])
           (cond
             [(= mid-val num) mid-val]
             [(< mid-val num) (loop (+ mid 1) right)]
             [else (loop left (- mid 1))]))])))

  (define (calculate-sum original-sum reduction)
    (modulo (- original-sum reduction) (+ 10e9 7)))

  (let* ([original-sum (foldl (lambda (x y acc) (modulo (+ acc (abs-diff x y)) (+ 10e9 7))) 0 nums1 nums2)]
         [max-reduction 0])
    (for/fold ([current-max-reduction max-reduction])
              ([i (in-range n)])
      (let* ([num1 (list-ref nums1 i)]
             [num2 (list-ref nums2 i)]
             [closest (find-closest num2)]
             [reduction (abs-diff num1 num2)]
             [new-reduction (abs-diff closest num2)]
             [difference (- reduction new-reduction)])
        (max current-max-reduction difference)))
    (calculate-sum original-sum max-reduction)))