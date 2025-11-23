(define (max-sum-submatrix matrix k)
  (define rows (length matrix))
  (define cols (length (first matrix)))
  (define max-sum -inf.0)

  (for ([left (in-range cols)])
    (define sums (make-vector rows 0))
    (for ([right (in-range left cols)])
      (for ([i (in-range rows)])
        (vector-set! sums i (+ (vector-ref sums i) (list-ref (list-ref matrix i) right))))

      (define (solve-for-k arr k)
        (define sorted-sums (list 0))
        (define current-sum 0)
        (define max-so-far -inf.0)

        (for ([num (in-vector arr)])
          (set! current-sum (+ current-sum num))
          (define ceiling (find-ceiling sorted-sums (- current-sum k)))
          (when ceiling
            (set! max-so-far (max max-so-far (- current-sum ceiling))))
          (set! sorted-sums (insert-sorted sorted-sums current-sum)))

        max-so-far)

      (define (find-ceiling sorted-sums target)
        (define (binary-search left right)
          (cond
            [(> left right) #f]
            [else
             (define mid (floor (+ left right) 2))
             (define mid-val (list-ref sorted-sums mid))
             (cond
               [(= mid-val target) mid-val]
               [(< mid-val target) (binary-search (+ mid 1) right)]
               [else
                (or (binary-search left (- mid 1)) mid-val))]]))
        (binary-search 0 (- (length sorted-sums) 1)))

      (define (insert-sorted sorted-sums val)
        (cond
          [(null? sorted-sums) (list val)]
          [(< val (first sorted-sums)) (cons val sorted-sums)]
          [else (cons (first sorted-sums) (insert-sorted (cdr sorted-sums) val))]))

      (set! max-sum (max max-sum (solve-for-k sums k)))))

  max-sum)