(define (num-binary-trees-with-factors arr)
  (define MOD 1000000007)

  (define sorted-arr (sort arr <))
  (define dp-map (make-hash))

  (for-each (lambda (x) (hash-set! dp-map x 1)) sorted-arr)

  (define n (length sorted-arr))

  (for ([i (in-range n)])
    (define root-val (list-ref sorted-arr i))
    (for ([j (in-range i)])
      (define left-val (list-ref sorted-arr j))

      (when (= (modulo root-val left-val) 0)
        (define right-val (/ root-val left-val))

        (when (hash-has-key? dp-map right-val)
          (define count-left (hash-ref dp-map left-val))
          (define count-right (hash-ref dp-map right-val))

          (define current-root-count (hash-ref dp-map root-val))
          (define new-root-count
            (modulo (+ current-root-count (* count-left count-right)) MOD))
          (hash-set! dp-map root-val new-root-count)))))

  (define total-trees 0)
  (hash-for-each
    (lambda (k v)
      (set! total-trees (modulo (+ total-trees v) MOD)))
    dp-map)

  total-trees)