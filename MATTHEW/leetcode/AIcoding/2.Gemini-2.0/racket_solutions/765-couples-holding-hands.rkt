(define (minSwapsCouples row)
  (define n (length row))
  (define p (make-vector n))
  (for ([i (in-range n)])
    (vector-set! p (list-ref row i) i))

  (define (find-set x)
    (if (= x (vector-ref parent x))
        x
        (let ((root (find-set (vector-ref parent x))))
          (vector-set! parent x root)
          root)))

  (define (union x y)
    (let ((rootX (find-set x))
          (rootY (find-set y)))
      (if (!= rootX rootY)
          (vector-set! parent rootX rootY))))

  (define parent (make-vector (/ n 2)))
  (for ([i (in-range (/ n 2))])
    (vector-set! parent i i))

  (for ([i (in-range 0 n 2)])
    (union (/ (vector-ref p (list-ref row i)) 2) (/ (vector-ref p (list-ref row (+ i 1))) 2)))

  (define components 0)
  (define visited (make-vector (/ n 2) #f))
  (for ([i (in-range (/ n 2))])
    (let ((root (find-set i)))
      (if (not (vector-ref visited root))
          (begin
            (vector-set! visited root #t)
            (set! components (+ components 1))))))
  (- (/ n 2) components))