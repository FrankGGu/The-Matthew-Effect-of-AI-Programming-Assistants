(define (sum-of-distances arr)
  (let* ((n (length arr))
         (indices (make-hash))
         (result (make-vector n 0)))

    (for/list ((i (in-range n)))
      (let ((x (list-ref arr i)))
        (hash-update! indices x (lambda (v) (cons i v)) (list i))))

    (for ((x (in-list (hash-keys indices))))
      (let* ((idx-list (sort (hash-ref indices x) <))
             (len (length idx-list)))
        (let loop ((i 1)
                   (sum (list-ref idx-list 0))
                   (prefix-sum (list-ref idx-list 0)))
          (cond
            ((= i len) #t)
            (else
             (let ((curr-idx (list-ref idx-list i)))
               (vector-set! result curr-idx (+ (* i x) (- prefix-sum)
                                                (* (- len i) x) (- (apply + (cdr (reverse idx-list) i)))
                                                (vector-ref result (list-ref idx-list 0))))
               (loop (+ i 1) (+ sum curr-idx) (+ prefix-sum curr-idx))))))))

    (vector->list result)))