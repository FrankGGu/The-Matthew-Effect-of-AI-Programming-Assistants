(define (count-connected-components-in-lcm-graph nums)
  (define max-val (foldl max 0 nums))

  (define is-present (make-vector (+ max-val 1) #f))
  (for-each (lambda (x) (vector-set! is-present x #t)) nums)

  (define parents (make-vector (+ max-val 1)))
  (define sizes (make-vector (+ max-val 1) 1))
  (for ([i (in-range (+ max-val 1))])
    (vector-set! parents i i))

  (define (find i)
    (if (= (vector-ref parents i) i)
        i
        (let ([root (find (vector-ref parents i))])
          (vector-set! parents i root)
          root)))

  (define (union i j)
    (let ([root-i (find i)]
          [root-j (find j)])
      (unless (= root-i root-j)
        (if (< (vector-ref sizes root-i) (vector-ref sizes root-j))
            (begin
              (vector-set! parents root-i root-j)
              (vector-set! sizes root-j (+ (vector-ref sizes root-j) (vector-ref sizes root-i))))
            (begin
              (vector-set! parents root-j root-i)
              (vector-set! sizes root-i (+ (vector-ref sizes root-i) (vector-ref sizes root-j))))))))

  (for ([i (in-range 1 (+ max-val 1))])
    (when (vector-ref is-present i)
      (for ([j (in-range (* 2 i) (+ max-val 1) i)])
        (when (vector-ref is-present j)
          (union i j)))))

  (define roots (make-hash))
  (for-each (lambda (x) (hash-set! roots (find x) #t)) nums)

  (hash-count roots))