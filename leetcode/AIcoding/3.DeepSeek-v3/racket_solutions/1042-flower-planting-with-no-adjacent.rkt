(define (garden-no-adj n paths)
  (define graph (make-hash))
  (for ([path paths])
    (let ([u (car path)]
          [v (cadr path)])
      (hash-update! graph u (lambda (lst) (cons v lst)) '())
      (hash-update! graph v (lambda (lst) (cons u lst)) '())))

  (define colors (make-vector n 0))

  (for ([i (in-range 1 (add1 n))])
    (let ([used-colors (list->set (map (lambda (neighbor) (vector-ref colors (sub1 neighbor))) 
                                       (hash-ref graph i '())))])
      (for ([color (in-range 1 5)])
        (unless (set-member? used-colors color)
          (vector-set! colors (sub1 i) color)
          (break)))))

  (vector->list colors))