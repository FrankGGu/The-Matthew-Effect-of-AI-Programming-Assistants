(define (kth-smallest-prime-fraction arr k)
  (let* ([n (length arr)]
         [all-fractions
          (for*/list ([i (in-range 0 (- n 1))]
                      [j (in-range (+ i 1) n)])
            (list (list-ref arr i) (list-ref arr j)))])

    (define (fraction-less? f1 f2)
      (< (* (car f1) (cadr f2))
         (* (car f2) (cadr f1))))

    (define sorted-fractions (sort all-fractions fraction-less?))

    (list-ref sorted-fractions (- k 1))))