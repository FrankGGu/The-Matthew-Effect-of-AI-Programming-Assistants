(define (min-operations nums)
  (define counts (make-hash))
  (for-each (lambda (x) (hash-update! counts x (lambda (v) (if (void? v) 1 (+ v 1))) 1)) nums)

  (define (calculate-operations count)
    (cond
      [(< count 2) -1]
      [(= count 2) 1]
      [(= count 3) 1]
      [(even? count) (/ count 2)]
      [else (+ 1 (/ (- count 3) 2))]))

  (let loop ([h counts] [ops 0])
    (if (hash-empty? h)
        ops
        (let* ([key (hash-first-key h)]
               [count (hash-ref h key)]
               [operations (calculate-operations count)])
          (if (= operations -1)
              -1
              (loop (hash-remove h key) (+ ops operations)))))))