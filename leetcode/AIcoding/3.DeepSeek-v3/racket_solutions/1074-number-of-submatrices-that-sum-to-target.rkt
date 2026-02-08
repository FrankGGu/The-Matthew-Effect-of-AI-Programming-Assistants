(define/contract (num-submatrix-sum-target matrix target)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (define m (length matrix))
  (define n (if (zero? m) 0 (length (car matrix))))
  (define prefix (make-vector (+ m 1) (make-vector (+ n 1) 0)))

  (for ([i (in-range 1 (+ m 1))])
    (for ([j (in-range 1 (+ n 1))])
      (vector-set! (vector-ref prefix i) j
                   (+ (vector-ref (vector-ref (vector-ref prefix (sub1 i)) j))
                      (vector-ref (vector-ref (vector-ref prefix i) (sub1 j)))
                      (- (vector-ref (vector-ref (vector-ref prefix (sub1 i)) (sub1 j))))
                      (list-ref (list-ref matrix (sub1 i)) (sub1 j))))))

  (define count 0)

  (for ([x1 (in-range 1 (+ m 1))])
    (for ([x2 (in-range x1 (+ m 1))])
      (define freq (make-hash))
      (hash-set! freq 0 1)
      (for ([y (in-range 1 (+ n 1))])
        (define sum (+ (vector-ref (vector-ref prefix x2) y)
                       (- (vector-ref (vector-ref prefix (sub1 x1)) y))))
        (define key (- sum target))
        (set! count (+ count (hash-ref freq key 0)))
        (hash-set! freq sum (add1 (hash-ref freq sum 0))))))

  count)