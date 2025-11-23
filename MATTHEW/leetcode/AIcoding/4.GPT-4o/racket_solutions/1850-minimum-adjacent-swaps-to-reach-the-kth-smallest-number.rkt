(define (getMinSwaps num k)
  (define (count-swaps arr)
    (define swaps 0)
    (for ([i (in-range (length arr))])
      (for ([j (in-range (+ i 1) (length arr))])
        (when (> (list-ref arr i) (list-ref arr j))
          (set! swaps (+ swaps 1)))))
    swaps)

  (define sorted-num (sort (string->list num) char<?))
  (define target (list->string sorted-num))

  (define (find-target-index n)
    (define (helper lst idx)
      (cond
        [(= idx (length lst)) -1]
        [(equal? (list-ref lst idx) (string->list target)) idx]
        [else (helper lst (+ idx 1))]))
    (helper (string->list n) 0))

  (define target-index (find-target-index (string->list num)))
  (define swaps (count-swaps (string->list num)))

  (if (>= target-index 0)
    swaps
    -1))