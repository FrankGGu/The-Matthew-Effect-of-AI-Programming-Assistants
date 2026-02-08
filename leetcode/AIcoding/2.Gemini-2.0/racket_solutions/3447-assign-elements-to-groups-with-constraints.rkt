(define (assign-groups n preferences)
  (define (valid-group? group i)
    (for/and ([j (in-range (vector-length preferences))])
      (or (not (vector-ref preferences j))
          (not (and (= (vector-ref group j) i)
                    (vector-ref preferences j))))))

  (define (solve group k)
    (cond
      [(>= k n) (if (for/and ([i (in-range 3)])
                       (for/and ([j (in-range n)])
                         (if (= (vector-ref group j) i)
                             (valid-group? group i)
                             #t)))
                    (list->vector (vector->list group))
                    #f)]
      [else
       (for/first ([i (in-range 3)]
                   #:when (begin
                            (vector-set! group k i)
                            (let ([valid? (valid-group? group i)])
                              (vector-set! group k (vector-ref group k))
                              valid?)))
         (begin
           (vector-set! group k i)
           (let ([result (solve group (+ k 1))])
             (if result
                 result
                 (begin
                   (vector-set! group k (vector-ref group k))
                   #f)))))]))

  (let ([group (make-vector n 0)])
    (solve group 0)))