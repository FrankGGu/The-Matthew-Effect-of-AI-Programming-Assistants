(define (most-beautiful-item items queries)
  (define (binary-search arr target)
    (let loop ((low 0) (high (length arr)))
      (if (>= low high)
          high
          (let ((mid (+ low (quotient (- high low) 2))))
            (if (>= (vector-ref arr mid) target)
                (loop low mid)
                (loop (+ mid 1) high))))))

  (define item-values (map (lambda (item) (vector-ref item 1)) items))
  (define item-weights (map (lambda (item) (vector-ref item 0)) items))
  (define sorted-items (sort items (lambda (a b) (> (vector-ref a 1) (vector-ref b 1)))))
  (define results '())

  (for ((query queries))
    (let* ((index (binary-search item-weights query))
           (best-item (if (> index 0) (vector-ref sorted-items (- index 1)) #f)))
      (set! results (cons (if best-item (vector-ref best-item 1) 0) results))))

  (reverse results))

(define items (list (vector 1 5) (vector 3 10) (vector 2 3)))
(define queries (list 2 3 4))
(most-beautiful-item items queries)