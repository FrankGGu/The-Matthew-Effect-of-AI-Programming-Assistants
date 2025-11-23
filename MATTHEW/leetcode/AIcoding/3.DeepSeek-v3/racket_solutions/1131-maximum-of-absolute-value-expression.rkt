(define (max-abs-val-expr arr1 arr2)
  (define n (length arr1))
  (define (compute-max a b c d)
    (max (apply max (map (lambda (x) (abs x)) a))
         (apply max (map (lambda (x) (abs x)) b))
         (apply max (map (lambda (x) (abs x)) c))
         (apply max (map (lambda (x) (abs x)) d)))
  (let* ([l1 (for/list ([i (in-range n)]) (+ (list-ref arr1 i) (list-ref arr2 i) i))]
         [l2 (for/list ([i (in-range n)]) (+ (list-ref arr1 i) (list-ref arr2 i) (- i)))]
         [l3 (for/list ([i (in-range n)]) (- (list-ref arr1 i) (list-ref arr2 i) i)]
         [l4 (for/list ([i (in-range n)]) (- (list-ref arr1 i) (list-ref arr2 i) (- i))])
    (compute-max l1 l2 l3 l4)))