#lang racket

(define (make-union-find n)
  (let ([parent (make-vector (+ n 1)))
        [rank (make-vector (+ n 1) 0)]
        [components n])
    (for ([i (range 1 (+ n 1))])
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
        (if (= root-i root-j)
            #f
            (begin
              (let ([rank-i (vector-ref rank root-i)]
                    [rank-j (vector-ref rank root-j)])
                (cond
                  ((> rank-i rank-j) (vector-set! parent root-j root-i))
                  ((< rank-i rank-j) (vector-set! parent root-i root-j))
                  (else
                   (vector-set! parent root-j root-i)
                   (vector-set! rank root-i (+ rank-i 1)))))
              (set! components (- components 1))
              #t))))
    (list find union (lambda () components))))

(define (max-num-edges-to-remove n edges)
  (let* ([uf-alice (make-union-find n)]
         [find-a (car uf-alice)]
         [union-a (cadr uf-alice)]
         [get-components-a (caddr uf-alice)]

         [uf-bob (make-union-find n)]
         [find-b (car uf-bob)]
         [union-b (cadr uf-bob)]
         [get-components-b (caddr uf-bob)]

         [edges-kept 0]
         [total-edges (length edges)])

    (define sorted-edges (sort edges (lambda (e1 e2) (> (car e1) (car e2)))))

    (for ([edge sorted-edges])
      (let ([type (car edge)]
            [u (cadr edge)]
            [v (caddr edge)])
        (when (= type 3)
          (let ([merged-a (union-a u v)]
                [merged-b (union-b u v)])
            (when (or merged-a merged-b)
              (set! edges-kept (+ edges-kept 1)))))))

    (for ([edge sorted-edges])
      (let ([type (car edge)]
            [u (cadr edge)]
            [v (caddr edge)])
        (when (= type 1)
          (when (union-a u v)
            (set! edges-kept (+ edges-kept 1))))))

    (for ([edge sorted-edges])
      (let ([type (car edge)]
            [u (cadr edge)]
            [v (caddr edge)])
        (when (= type 2)
          (when (union-b u v)
            (set! edges-kept (+ edges-kept 1))))))

    (if (and (= (get-components-a) 1)
             (= (get-components-b) 1))
        (- total-edges edges-kept)
        -1)))