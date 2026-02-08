(define (find-latest-group arr m)
  (let* ([n (length arr)]
         [parent (make-vector (add1 n) 0)]
         [size (make-vector (add1 n) 1)]
         [count 0]
         [ans -1])
    (define (find x)
      (if (= (vector-ref parent x) 0)
          x
          (let ([root (find (vector-ref parent x))])
            (vector-set! parent x root)
            root)))
    (define (union x y)
      (let* ([rootX (find x)]
             [rootY (find y)])
        (if (= rootX rootY)
            void
            (begin
              (if (< (vector-ref size rootX) (vector-ref size rootY))
                  (begin
                    (vector-set! parent rootX rootY)
                    (vector-set! size rootY (+ (vector-ref size rootX) (vector-ref size rootY))))
                  (begin
                    (vector-set! parent rootY rootX)
                    (vector-set! size rootX (+ (vector-ref size rootX) (vector-ref size rootY)))))))))
    (for/list ([i (in-range 0 n)])
      (let ([x (list-ref arr i)])
        (vector-set! parent x x)
        (if (= m 1) (set! count (+ count 1)))
        (if (> x 1)
            (if (= (vector-ref parent (- x 1)) (- x 1))
                (let ([rootX (find x)]
                      [rootY (find (- x 1))])
                  (if (= (vector-ref size rootX) m) (set! count (- count 1)))
                  (if (= (vector-ref size rootY) m) (set! count (- count 1)))
                  (union x (- x 1))
                  (let ([root (find x)])
                    (if (= (vector-ref size root) m) (set! count (+ count 1)))))))
        (if (< x n)
            (if (= (vector-ref parent (+ x 1)) (+ x 1))
                (let ([rootX (find x)]
                      [rootY (find (+ x 1))])
                  (if (= (vector-ref size rootX) m) (set! count (- count 1)))
                  (if (= (vector-ref size rootY) m) (set! count (- count 1)))
                  (union x (+ x 1))
                  (let ([root (find x)])
                    (if (= (vector-ref size root) m) (set! count (+ count 1)))))))
        (if (= count 0)
            void
            (set! ans (+ i 1)))))
    ans))