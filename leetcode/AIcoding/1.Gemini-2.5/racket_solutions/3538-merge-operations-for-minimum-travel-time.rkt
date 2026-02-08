#lang racket

(define (merge-operations-for-minimum-travel-time n edges)
  (define parent (make-vector n 0))
  (define ranks (make-vector n 0))

  (for ([i (in-range n)])
    (vector-set! parent i i))

  (define (find i)
    (if (= (vector-ref parent i) i)
        i
        (let ([root (find (vector-ref parent i))])
          (vector-set! parent i root)
          root)))

  (define (union i j)
    (let ([root-i (find i)]
          [root-j (find j)])
      (unless (= root-i root-j)
        (let ([rank-i (vector-ref ranks root-i)]
              [rank-j (vector-ref ranks root-j)])
          (cond
            [(> rank-i rank-j) (vector-set! parent root-j root-i)]
            [(< rank-i rank-j) (vector-set! parent root-i root-j)]
            [else
             (vector-set! parent root-j root-i)
             (vector-set! ranks root-i (+ rank-i 1))]))
        #t)))

  (define sorted-edges (sort edges (lambda (e1 e2) (< (caddr e1) (caddr e2)))))

  (define min-cost 0)
  (define num-components n)

  (for ([edge sorted-edges])
    (let ([u (car edge)]
          [v (cadr edge)]
          [weight (caddr edge)])
      (when (union u v)
        (set! min-cost (+ min-cost weight))
        (set! num-components (- num-components 1))
        (when (= num-components 1)
          (break)))))

  (if (= num-components 1)
      min-cost
      -1))