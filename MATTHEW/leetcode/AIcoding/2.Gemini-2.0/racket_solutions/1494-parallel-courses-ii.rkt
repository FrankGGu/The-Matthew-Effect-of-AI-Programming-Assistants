(define (min-number-of-semesters n dependencies k)
  (define in-degree (make-vector (add1 n) 0))
  (define adj (make-vector (add1 n) null))
  (for ([dep dependencies])
    (let ([u (first dep)] [v (second dep)])
      (vector-set! in-degree v (add1 (vector-ref in-degree v)))
      (vector-set! adj u (cons v (vector-ref adj u)))))

  (define (solve mask)
    (if (= mask (expt 2 n))
        0
        (let ([memo (make-hash)])
          (define (helper mask)
            (cond
              [(hash-has-key? memo mask) (hash-ref memo mask)]
              [else
               (let ([eligible null])
                 (for ([i (range n)])
                   (when (and (= (bitwise-and mask (expt 2 i)) 0)
                              (let ([is-ready #t])
                                (for ([v (range 1 (add1 n))])
                                  (when (= (sub1 v) i)
                                    (for ([u (range 1 (add1 n))])
                                      (for ([vv (vector-ref adj u)])
                                        (when (= vv v)
                                          (when (= (bitwise-and mask (expt 2 (sub1 u))) 0)
                                            (set! is-ready #f)))))))
                                is-ready))
                     (set! eligible (cons i eligible))))
                 (if (null? eligible)
                     #f
                     (let ([groups (combinations eligible k)])
                       (let loop ([groups groups] [min-semesters #f])
                         (cond
                           [(null? groups) min-semesters]
                           [else
                            (let ([group (first groups)])
                              (let ([new-mask mask])
                                (for ([i group])
                                  (set! new-mask (bitwise-ior new-mask (expt 2 i)))))
                                (let ([next-val (helper new-mask)])
                                  (if next-val
                                      (let ([new-semesters (add1 next-val)])
                                        (cond
                                          [(not min-semesters) (loop (rest groups) new-semesters)]
                                          [(< new-semesters min-semesters) (loop (rest groups) new-semesters)]
                                          [else (loop (rest groups) min-semesters)]))
                                      (loop (rest groups) min-semesters))))))))))))))
          (let ([result (helper 0)])
            (hash-set! memo mask result)
            result)))))
  (solve 0))