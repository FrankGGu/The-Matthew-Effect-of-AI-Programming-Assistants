(define (min-wasted packages boxes)
  (define sorted-packages (sort packages <))
  (define min-waste (make-mutable-hash))
  (hash-set! min-waste #t #f) ; Initialize to false (no waste found yet)

  (define (calculate-waste box)
    (let* ([sorted-box (sort box <)]
           [n (length sorted-packages)]
           [waste 0]
           [valid? #t])
      (for ([package sorted-packages])
        (define found? #f)
        (for ([b sorted-box])
          (when (>= b package)
            (set! waste (+ waste (- b package)))
            (set! found? #t)
            (break)))
        (unless found?
          (set! valid? #f)
          (break)))

      (if valid? waste #f)))

  (for ([box boxes])
    (let ([waste (calculate-waste box)])
      (when waste
        (cond
          [(not (hash-ref min-waste #t #f))
           (hash-set! min-waste #t waste)]
          [(< waste (hash-ref min-waste #t #f))
           (hash-set! min-waste #t waste)]))))

  (define result (hash-ref min-waste #t #f))
  (if result (modulo result 1000000007) -1))