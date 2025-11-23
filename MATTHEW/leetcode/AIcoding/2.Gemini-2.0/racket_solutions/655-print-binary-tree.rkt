(define (print-tree root)
  (define (tree-height node)
    (if (null? node)
        0
        (+ 1 (max (tree-height (car node)) (tree-height (cadr node))))))

  (define height (tree-height root))
  (define width (expt 2 height) (- 1))

  (define result (make-vector height (make-vector width "")))

  (define (fill-result node row left right)
    (if (not (null? node))
        (let* ((mid (+ left right) (/ 2)))
          (vector-set! (vector-ref result row) mid (number->string (caddr node)))
          (fill-result (car node) (+ row 1) left (- mid 1))
          (fill-result (cadr node) (+ row 1) (+ mid 1) right))))

  (fill-result root 0 0 (- width 1))

  (define lst '())
  (for ([i (in-range height)])
    (define row-lst '())
    (for ([j (in-range width)])
      (set! row-lst (append row-lst (list (vector-ref (vector-ref result i) j)))))
    (set! lst (append lst (list row-lst))))

  lst)