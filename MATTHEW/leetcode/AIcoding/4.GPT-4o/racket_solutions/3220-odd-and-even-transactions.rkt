(define (oddEvenJumps A)
  (define n (length A))
  (define odd (make-vector n #f))
  (define even (make-vector n #f))
  (define jump (lambda (i j) (if (>= j n) #f (if (even? i) (and (<= (vector-ref A j) (vector-ref A i)) (vector-ref even j)) (and (>= (vector-ref A j) (vector-ref A i)) (vector-ref odd j))))))

  (vector-set! odd (sub1 n) #t)
  (vector-set! even (sub1 n) #t)

  (define sorted-indices (sort (map-indexed (lambda (i x) (cons x i)) A) (lambda (x y) (< (car x) (car y)))))

  (for ([i (in-vector sorted-indices)])
    (define idx (cdr i))
    (for ([j (in-range idx n)])
      (when (jump idx j)
        (vector-set! odd idx #t)
        (when (even? idx) (vector-set! even j #t)))))

  (define (count-true vec) (for/sum ([i (in-vector vec)] #:when i) 1))

  (+ (count-true odd) (count-true even)))