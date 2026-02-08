(define (custom-sort-string order str)
  (let* ([order-map (make-hash)]
         [_ (for ([i (in-range (string-length order))])
              (hash-set! order-map (string-ref order i) i))]
         [sorted-str (list->string (sort (string->list str)
                                          (lambda (a b)
                                            (let ([a-order (hash-ref order-map a #f)]
                                                  [b-order (hash-ref order-map b #f)])
                                              (cond
                                                [(and a-order b-order) (< a-order b-order)]
                                                [a-order #f]
                                                [b-order #t]
                                                [else #f]))))))])
    sorted-str))