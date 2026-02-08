#lang racket

(require data/heap)

(define/contract (minimum-visited-cells grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define m (length grid))
  (define n (if (zero? m) 0 (length (car grid))))
  (define dist (make-vector m (make-vector n -1)))
  (vector-set! (vector-ref dist 0) 0 1)

  (define row-heaps (make-vector m #f))
  (define col-heaps (make-vector n #f))

  (for ([i (in-range m)])
    (vector-set! row-heaps i (make-heap (λ (a b) (<= (car a) (car b)))))
  (for ([j (in-range n)])
    (vector-set! col-heaps j (make-heap (λ (a b) (<= (car a) (car b)))))

  (heap-add! (vector-ref row-heaps 0) (cons 0 0))
  (heap-add! (vector-ref col-heaps 0) (cons 0 0))

  (let loop ()
    (define min-row #f)
    (define min-col #f)
    (for ([i (in-range m)])
      (let ([heap (vector-ref row-heaps i)])
        (unless (heap-empty? heap)
          (let ([top (heap-min heap)])
            (when (and (not min-row) (or (not min-row) (< (car top) (car min-row))))
              (set! min-row top))))))
    (for ([j (in-range n)])
      (let ([heap (vector-ref col-heaps j)])
        (unless (heap-empty? heap)
          (let ([top (heap-min heap)])
            (when (and (not min-col) (or (not min-col) (< (car top) (car min-col))))
              (set! min-col top))))))

    (cond
      [(and (not min-row) (not min-col)) -1]
      [(or (not min-col) (and min-row (< (car min-row) (car min-col))))
       (let* ([i (cdr min-row)]
              [j (heap-min (vector-ref row-heaps i))]
              [d (car j)]
              [g (vector-ref (vector-ref grid i) j)])
         (heap-remove! (vector-ref row-heaps i) j)
         (for ([k (in-range (add1 j) (min n (+ j g 1)))])
           (when (= (vector-ref (vector-ref dist i) k) -1)
             (vector-set! (vector-ref dist i) k (add1 d))
             (heap-add! (vector-ref row-heaps i) (cons (add1 d) k))
             (heap-add! (vector-ref col-heaps k) (cons (add1 d) i)))))
         (loop))]
      [else
       (let* ([j (cdr min-col)]
              [i (heap-min (vector-ref col-heaps j))]
              [d (car i)]
              [g (vector-ref (vector-ref grid i) j)])
         (heap-remove! (vector-ref col-heaps j) i)
         (for ([k (in-range (add1 i) (min m (+ i g 1)))])
           (when (= (vector-ref (vector-ref dist k) j) -1)
             (vector-set! (vector-ref dist k) j (add1 d))
             (heap-add! (vector-ref row-heaps k) (cons (add1 d) j))
             (heap-add! (vector-ref col-heaps j) (cons (add1 d) k)))))
         (loop))])))

  (vector-ref (vector-ref dist (sub1 m)) (sub1 n)))