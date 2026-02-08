(define (longest-obstacle-course-at-each-position obstacles)
  (define n (length obstacles))
  (define dp (make-vector n 0))
  (define lis (make-vector n 0))
  (define len 0)

  (for ([i (in-range n)])
    (define idx (binary-search (lambda (j) (<= (vector-ref lis j) (vector-ref obstacles i))) len))
    (vector-set! lis idx (vector-ref obstacles i))
    (when (= idx len) (set! len (add1 len)))
    (vector-set! dp i (add1 idx)))

  dp)

(define (binary-search pred right)
  (define left 0)
  (define (helper left right)
    (if (>= left right)
        left
        (let ([mid (quotient (+ left right) 2)])
          (if (pred mid)
              (helper left mid)
              (helper (add1 mid) right)))))
  (helper left right))

(define (find-longest-valid-obstacle-course obstacles)
  (longest-obstacle-course-at-each-position obstacles))