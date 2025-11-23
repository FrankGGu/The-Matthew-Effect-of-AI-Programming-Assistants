(define (kth-smallest-matrix-sum mat k)
  (define (heap-push heap x)
    (heap-add! heap x))

  (define (heap-pop heap)
    (heap-remove-min! heap))

  (define (heap-peek heap)
    (heap-min heap))

  (define (heap-empty? heap)
    (heap-empty? heap))

  (define (generate-sums sums row-idx current-sum)
    (if (= row-idx (length mat))
        (void)
        (for ([val (in-list (list-ref mat row-idx))])
          (generate-sums sums (+ row-idx 1) (+ current-sum val)))))

  (define (solve mat k)
    (define rows (length mat))
    (define cols (length (list-ref mat 0)))

    (define initial-sum 0)
    (for ([i (in-range rows)])
      (set! initial-sum (+ initial-sum (list-ref (list-ref mat i) 0))))

    (define min-heap (make-heap <))
    (heap-push min-heap (list initial-sum (make-vector rows 0)))

    (define seen (make-hash))
    (hash-set! seen (vector->list (vector-ref (heap-peek min-heap) 1)) #t)

    (define count 0)
    (let loop ()
      (if (= count k)
          (vector-ref (heap-peek min-heap) 0)
          (begin
            (define current (heap-pop min-heap))
            (define current-sum (vector-ref current 0))
            (define current-indices (vector-ref current 1))
            (set! count (+ count 1))

            (for ([i (in-range rows)])
              (if (< (vector-ref current-indices i) (- cols 1))
                  (let* ([new-indices (copy-vector current-indices)]
                         [new-sum (+ current-sum (- (list-ref (list-ref mat i) (+ (vector-ref current-indices i) 1)) (list-ref (list-ref mat i) (vector-ref current-indices i))))])
                    (vector-set! new-indices i (+ (vector-ref current-indices i) 1))
                    (unless (hash-ref seen (vector->list new-indices) #f)
                      (heap-push min-heap (vector new-sum new-indices))
                      (hash-set! seen (vector->list new-indices) #t))))))
            (loop)))))

  (solve mat k))