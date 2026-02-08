(define (find-missing-and-repeated arr)
  (define n (length arr))
  (define counts (make-vector (+ n 1) 0))
  (for-each (lambda (x) (vector-set! counts x (+ 1 (vector-ref counts x)))) arr)
  (for/fold ([missing 0] [repeated 0]) ([i 1 (+ n 1)])
    (cond
      [(= (vector-ref counts i) 0) (values i repeated)]
      [(= (vector-ref counts i) 2) (values missing i)]
      [else (values missing repeated)])))

(define (findRepeatedAndMissing arr)
  (define values (find-missing-and-repeated arr))
  (list (cdr values) (car values)))