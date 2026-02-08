(define (get-power n)
  (let loop ([num n] [count 0])
    (cond
      [(= num 1) count]
      [(even? num) (loop (/ num 2) (+ count 1))]
      [else (loop (+ (* 3 num) 1) (+ count 1))])))

(define (sort-by-power arr k)
  (let* ([powers (map get-power arr)]
         [indexed-powers (map list arr powers)]
         [sorted-indexed-powers (sort indexed-powers (lambda (x y)
                                                         (cond
                                                           [(= (cadr x) (cadr y)) (< (car x) (car y))]
                                                           [else (< (cadr x) (cadr y))])))]
         [sorted-arr (map car sorted-indexed-powers)])
    (list-ref sorted-arr (- k 1))))