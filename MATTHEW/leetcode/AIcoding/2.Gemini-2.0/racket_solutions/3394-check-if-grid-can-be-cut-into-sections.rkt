(define (is-valid-section? grid row1 col1 row2 col2)
  (let loop ([r row1])
    (if (= r row2)
        #t
        (let loop2 ([c col1])
          (if (= c col2)
              (loop (+ r 1))
              (if (= (list-ref (list-ref grid r) c) 1)
                  #f
                  (loop2 (+ c 1))))))))

(define (check-grid grid k)
  (let ([rows (length grid)]
        [cols (length (list-ref grid 0))])
    (let loop ([r 0])
      (if (> r (- rows k))
          #f
          (let loop2 ([c 0])
            (if (> c (- cols k))
                (loop (+ r 1))
                (if (is-valid-section? grid r c (+ r k) (+ c k))
                    #t
                    (loop2 (+ c 1)))))))))