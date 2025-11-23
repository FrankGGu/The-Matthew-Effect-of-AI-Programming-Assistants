(define (remove-stones stones)
  (define n (length stones))
  (define parent (make-vector n))
  (for ([i (in-range n)])
    (vector-set! parent i i))

  (define (find x)
    (if (= (vector-ref parent x) x)
        x
        (let ([root (find (vector-ref parent x))])
          (vector-set! parent x root)
          root)))

  (define (union x y)
    (let ([rootx (find x)]
          [rooty (find y)])
      (if (!= rootx rooty)
          (vector-set! parent rootx rooty))))

  (for ([i (in-range n)]
        [j (in-range (+ i 1) n)])
    (let ([stone1 (list-ref stones i)]
          [stone2 (list-ref stones j)])
      (if (or (= (car stone1) (car stone2))
              (= (cadr stone1) (cadr stone2)))
          (union i j))))

  (define num-components 0)
  (define visited (make-vector n #f))
  (for ([i (in-range n)])
    (let ([root (find i)])
      (if (not (vector-ref visited root))
          (begin
            (vector-set! visited root #t)
            (set! num-components (+ num-components 1))))))

  (- n num-components))