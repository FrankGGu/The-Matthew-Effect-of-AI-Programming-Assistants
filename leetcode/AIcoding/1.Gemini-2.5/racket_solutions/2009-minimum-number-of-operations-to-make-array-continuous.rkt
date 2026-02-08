(define (minimum-operations-to-make-array-continuous nums)
  (define n (length nums))

  (if (zero? n)
      0
      (begin
        (define unique-sorted-nums (sort (set->list (list->set nums)) <))
        (define min-ops n)

        (define right 0)

        (for ([left (in-range (length unique-sorted-nums))])
          (define lower-bound (list-ref unique-sorted-nums left))
          (define upper-bound (+ lower-bound n -1))

          (let loop ()
            (when (< right (length unique-sorted-nums))
              (when (<= (list-ref unique-sorted-nums right) upper-bound)
                (set! right (+ right 1))
                (loop))))

          (define current-count (- right left))
          (set! min-ops (min min-ops (- n current-count))))

        min-ops)))