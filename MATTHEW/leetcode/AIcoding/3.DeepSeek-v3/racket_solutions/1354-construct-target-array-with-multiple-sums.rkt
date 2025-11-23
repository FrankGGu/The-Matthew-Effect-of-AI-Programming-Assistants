(define/contract (is-possible target)
  (-> (listof exact-integer?) boolean?)
  (let loop ([heap (make-heap (lambda (a b) (> a b)))]
             [total 0])
    (for ([num (in-list target)])
    (for ([num (in-list target)])
    (heap-add! heap num)
    (set! total (+ total num))
    (let loop-inner ()
      (let ([max-val (heap-remove! heap)])
      (if (= max-val 1)
          #t
          (let ([rest (- total max-val)])
            (if (or (<= rest 0) (= max-val rest))
                #f
                (let ([new-val (modulo max-val rest)])
                (if (= new-val 0)
                    #f
                    (begin
                      (heap-add! heap new-val)
                      (set! total (+ rest new-val))
                      (loop-inner))))))))))