(define/contract (rearrange-array nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let loop ([nums (sort nums <)])
    (cond [(<= (length nums) 2) nums]
          [else (let* ([n (length nums)]
                       [mid (quotient n 2)]
                       [left (take nums mid)]
                       [right (drop nums mid)]
                       [result (append (list (first right)) (loop left) (rest right))])
                  (if (valid? result)
                      result
                      (append (list (first left)) (loop right) (rest left)))))])))

(define/contract (valid? nums)
  (-> (listof exact-integer?) boolean?)
  (let loop ([i 1])
    (cond [(>= i (- (length nums) 1)) #t]
          [(= (list-ref nums i) (/ (+ (list-ref nums (- i 1)) (list-ref nums (+ i 1))) 2)) #f]
          [else (loop (+ i 1))])))