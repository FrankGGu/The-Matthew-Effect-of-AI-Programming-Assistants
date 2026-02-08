(define (min-operations target arr)
  (define (lis seq)
    (define tails (make-vector (add1 (length seq)) +inf.0))
    (define (update i x)
      (vector-set! tails i x))
    (define (binary-search x)
      (define (loop lo hi)
        (if (> lo hi)
            lo
            (let ((mid (quotient (+ lo hi) 2)))
              (if (<= (vector-ref tails mid) x)
                  (loop (add1 mid) hi)
                  (loop lo (sub1 mid))))))
      (loop 0 (length seq)))

    (for ([x seq])
      (let ((i (binary-search x)))
        (update i x)))

    (let loop ([i (sub1 (length tails))])
      (if (or (< i 0) (= (vector-ref tails i) +inf.0))
          i
          (loop (sub1 i)))))

  (let* ([target-set (set (in-list target))]
         [filtered-arr (filter (lambda (x) (set-member? target-set x)) arr)]
         [indices (map (lambda (x) (index-of target x)) filtered-arr)]
         [longest-increasing-subsequence (lis indices)])
    (- (length target) (add1 longest-increasing-subsequence))))

(define (index-of lst val)
  (let loop ([lst lst] [i 0])
    (cond
      [(empty? lst) #f]
      [(= (car lst) val) i]
      [else (loop (cdr lst) (add1 i))])))