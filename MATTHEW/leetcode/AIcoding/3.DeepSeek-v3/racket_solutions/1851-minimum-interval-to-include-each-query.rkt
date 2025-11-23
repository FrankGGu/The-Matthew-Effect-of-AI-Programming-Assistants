(define/contract (min-interval intervals queries)
  (-> (listof (listof exact-integer?)) (listof exact-integer?) (listof exact-integer?))
  (let* ([sorted-intervals (sort intervals (lambda (a b) (< (car a) (car b))))]
         [sorted-queries (sort (map (lambda (q i) (cons q i)) queries (range (length queries))) (lambda (a b) (< (car a) (car b))))]
         [min-heap (make-heap (lambda (a b) (< (car a) (car b))))]
         [res (make-vector (length queries) -1)]
         [i 0])
    (for ([query (in-list sorted-queries)])
      (let ([q (car query)]
            [idx (cdr query)])
        (while (and (< i (length sorted-intervals)) (<= (car (list-ref sorted-intervals i)) q))
          (let ([interval (list-ref sorted-intervals i)])
            (heap-add! min-heap (cons (- (cadr interval) (car interval) -1) (cadr interval)))
            (set! i (+ i 1)))
        (while (and (not (heap-empty? min-heap)) (> (cdar (heap-min min-heap)) q))
          (heap-remove-min! min-heap)
        (if (not (heap-empty? min-heap))
            (vector-set! res idx (caar (heap-min min-heap)))
            (vector-set! res idx -1))))
    (vector->list res)))