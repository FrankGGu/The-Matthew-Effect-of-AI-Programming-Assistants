(define (maximum-earnings n rides)
  (define rides-by-end (make-vector (+ n 1) '()))

  (for-each
   (lambda (ride)
     (let* ((start (list-ref ride 0))
            (end (list-ref ride 1))
            (tip (list-ref ride 2))
            (earning (+ (- end start) tip)))
       (vector-set! rides-by-end end (cons (cons start earning) (vector-ref rides-by-end end)))))
   rides)

  (define dp (make-vector (+ n 1) 0))

  (for ([i (in-range 1 (+ n 1))])
    (vector-set! dp i (vector-ref dp (- i 1)))

    (for-each
     (lambda (ride-info)
       (let* ((start (car ride-info))
              (earning (cdr ride-info))
              (current-total-earning (+ (vector-ref dp start) earning)))
         (when (> current-total-earning (vector-ref dp i))
           (vector-set! dp i current-total-earning))))
     (vector-ref rides-by-end i)))

  (vector-ref dp n))