(define (count-subtrees n edges labels)
  (let* ([graph (make-vector n '())]
         [result (make-vector n 0)]
         [labels-vec (list->vector (map char->integer (string->list labels)))])
    (for ([edge edges])
      (let ([u (car edge)]
            [v (cadr edge)])
        (vector-set! graph u (cons v (vector-ref graph u)))
        (vector-set! graph v (cons u (vector-ref graph v)))))

    (define (dfs node parent)
      (let ([count (make-vector 26 0)])
        (for-each (lambda (child)
                    (when (not (= child parent))
                      (let ([child-count (dfs child node)])
                        (for ([i 26])
                          (vector-set! count i (+ (vector-ref count i) (vector-ref child-count i)))))))
                  (vector-ref graph node))
        (let ([label (- (vector-ref labels-vec node) 97)])
          (vector-set! count label (+ (vector-ref count label) 1))
          (vector-set! result node (vector-ref count label)))
        count))

    (dfs 0 -1)
    (vector->list result)))