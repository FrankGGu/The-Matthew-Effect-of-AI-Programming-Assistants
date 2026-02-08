(define (count-incremovable-subarrays nums)
  (define n (length nums))
  (define count 0)

  (for* ([i (in-range n)]
         [j (in-range i n)])
    (define sub-array (append (take nums i) (drop nums j)))
    (define is-incremovable #t)

    (for/and ([k (in-range 1 (length sub-array))])
      (<= (list-ref sub-array (- k 1)) (list-ref sub-array k)))

    (when is-incremovable
      (set! count (+ count 1))))

  count)