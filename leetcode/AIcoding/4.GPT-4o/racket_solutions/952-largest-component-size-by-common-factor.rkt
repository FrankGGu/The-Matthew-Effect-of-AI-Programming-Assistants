(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (modulo a b))))

(define (largest-component-size A)
  (define n (length A))
  (define parent (make-vector (add1 (apply max A)) -1))

  (define (find x)
    (if (= (vector-ref parent x) -1)
        x
        (let ((root (find (vector-ref parent x))))
          (vector-set! parent x root)
          root)))

  (define (union x y)
    (define rootX (find x))
    (define rootY (find y))
    (if (not (= rootX rootY))
        (vector-set! parent rootX rootY)))

  (for-each (lambda (x)
              (for-each (lambda (y)
                          (union x y))
                        (filter (lambda (z) (not (= z x)))
                                A)))
            A)

  (define count (make-vector (length parent) 0))
  (for-each (lambda (x)
              (define root (find x))
              (vector-set! count root (+ 1 (vector-ref count root))))
            (for/fold ([i 0]) ([x A])
              (if (and (not (= x 0)) (not (= x 1)))
                  (begin
                    (set! i (+ i 1))
                    i)
                  i)))

  (apply max (vector->list count)))

(largest-component-size '(4 6 15 35))