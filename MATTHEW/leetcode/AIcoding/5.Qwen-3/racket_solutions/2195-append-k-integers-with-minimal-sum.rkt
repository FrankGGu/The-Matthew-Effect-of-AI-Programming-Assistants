(define (min-sum nums k)
  (define (heap? a b) (< a b))
  (define heap (list->heap nums heap?))
  (let loop ([i 0] [sum 0])
    (if (= i k)
        sum
        (let* ([min-val (heap-min heap)]
               [new-val (+ min-val 1)])
          (heap-remove! heap)
          (heap-add! heap new-val)
          (loop (+ i 1) (+ sum min-val))))))