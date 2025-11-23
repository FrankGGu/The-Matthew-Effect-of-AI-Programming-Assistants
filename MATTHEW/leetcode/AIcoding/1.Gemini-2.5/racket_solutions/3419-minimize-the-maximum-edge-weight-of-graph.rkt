#lang racket

(struct dsu (parent rank count) #:mutable)

(define (make-dsu n)
  (dsu (build-vector n (lambda (i) i))
       (build-vector n (lambda (i) 0))
       n))

(define (dsu-find dsu i)
  (let ([p (dsu-parent dsu)])
    (if (= (vector-ref p i) i)
        i
        (let ([root (dsu-find dsu (vector-ref p i))])
          (vector-set! p i root)
          root))))

(define (dsu-union dsu i j)
  (let ([root-i (dsu-find dsu i)]
        [root-j (dsu-find dsu j)])
    (unless (= root-i root-j)
      (let ([p (dsu-parent dsu)]
            [r (dsu-rank dsu)])
        (cond
          ((< (vector-ref r root-i) (vector-ref r root-j))
           (vector-set! p root-i root-j))
          ((> (vector-ref r root-i) (vector-ref r root-j))
           (vector-set! p root-j root-i))
          (else
           (vector-set! p root-j root-i)
           (vector-set! r root-i (+ (vector-ref r root-i) 1))))
        (set-dsu-count! dsu (- (dsu-count dsu) 1)))))
  (void))

(define (dsu-is-connected? dsu)
  (= (dsu-count dsu) 1))

(define (check max-weight n edges)
  (let ([dsu (make-dsu n)])
    (for-each (lambda (edge)
                (let ([u (car edge)]
                      [v (cadr edge)]
                      [w (caddr edge)])
                  (when (<= w max-weight)
                    (dsu-union dsu u v))))
              edges)
    (dsu-is-connected? dsu)))

(define (minimize-the-maximum-edge-weight-of-graph n edges)
  (let* ([max-w (apply max (map caddr edges))]
         [low 1]
         [high max-w]
         [ans max-w])
    (let loop ([low low] [high high] [ans ans])
      (if (> low high)
          ans
          (let ([mid (+ low (quotient (- high low) 2))])
            (if (check mid n edges)
                (loop low (- mid 1) mid)
                (loop (+ mid 1) high ans)))))))