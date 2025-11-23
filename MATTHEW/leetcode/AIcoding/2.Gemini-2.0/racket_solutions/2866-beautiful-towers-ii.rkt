(define (maximum-sum-of-heights maxHeights)
  (define n (vector-length maxHeights))

  (define left (make-vector n 0))
  (define right (make-vector n 0))

  (define stack '())
  (for/indexed ((i (in-range n)))
    (let loop ()
      (if (and (not (null? stack)) (<= (vector-ref maxHeights (car stack)) (vector-ref maxHeights i)))
          (begin
            (set! stack (cdr stack))
            (loop))
          (let ((prev (if (null? stack) -1 (car stack))))
            (vector-set! left i (+ (* (vector-ref maxHeights i) (- i prev -1)) (if (negative? prev) 0 (vector-ref left prev)))))
          )))
    (set! stack (cons i stack)))

  (set! stack '())
  (for/indexed ((i (in-range (- n 1) -1 -1)))
    (let loop ()
      (if (and (not (null? stack)) (<= (vector-ref maxHeights (car stack)) (vector-ref maxHeights i)))
          (begin
            (set! stack (cdr stack))
            (loop))
          (let ((prev (if (null? stack) n (car stack))))
            (vector-set! right i (+ (* (vector-ref maxHeights i) (- prev i -1)) (if (= prev n) 0 (vector-ref right prev)))))
          )))
    (set! stack (cons i stack)))

  (define max-sum 0)
  (for/indexed ((i (in-range n)))
    (set! max-sum (max max-sum (- (+ (vector-ref left i) (vector-ref right i)) (vector-ref maxHeights i)))))

  max-sum)