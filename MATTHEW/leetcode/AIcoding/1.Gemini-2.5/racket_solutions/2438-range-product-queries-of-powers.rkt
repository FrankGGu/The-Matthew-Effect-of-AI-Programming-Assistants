(define (range-product-queries n queries)
  (define MOD 1000000007)

  ;; Helper function to generate the sorted list of powers of 2
  ;; that sum up to n.
  (define (get-powers n)
    (let loop ((k n) (i 0) (acc '()))
      (if (zero? k)
          ;; Sort the accumulated powers in non-decreasing order
          (sort acc <)
          (loop (arithmetic-shift k -1) ; Equivalent to (floor k / 2)
                (+ i 1)
                (if (odd? k)             ; Check if the current bit is set
                    (cons (expt 2 i) acc)
                    acc)))))

  ;; Generate the powers list once
  (define powers-list (get-powers n))

  ;; Process each query
  (for/list ([query queries])
    (let* ([left (car query)]
           [right (cadr query)])
      ;; Calculate the product for the current range [left, right]
      (let loop ((idx left) (current-product 1))
        (if (> idx right)
            current-product
            (loop (+ idx 1)
                  (modulo (* current-product (list-ref powers-list idx)) MOD)))))))