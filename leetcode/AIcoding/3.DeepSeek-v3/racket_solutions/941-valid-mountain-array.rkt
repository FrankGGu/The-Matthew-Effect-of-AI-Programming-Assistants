(define/contract (valid-mountain-array arr)
  (-> (listof exact-integer?) boolean?)
  (let ([n (length arr)])
    (if (< n 3)
        #f
        (let loop ([i 1] [up #t])
          (cond
            [(>= i n) (not up)]
            [(and up (< (list-ref arr (- i 1)) (list-ref arr i))) (loop (+ i 1) #t)]
            [(and up (> (list-ref arr (- i 1)) (list-ref arr i))) (if (= i 1) #f (loop (+ i 1) #f))]
            [(and (not up) (> (list-ref arr (- i 1)) (list-ref arr i))) (loop (+ i 1) #f)]
            [else #f])))))