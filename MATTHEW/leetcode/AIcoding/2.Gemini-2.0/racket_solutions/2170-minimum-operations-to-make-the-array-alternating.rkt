(define (minimum-operations-to-make-alternating nums)
  (define n (length nums))
  (if (<= n 1) 0
      (let ([even-freq (make-hash)]
            [odd-freq (make-hash)])
        (for ([i (in-range n)])
          (if (even? i)
              (hash-update! even-freq (list-ref nums i) add1 0)
              (hash-update! odd-freq (list-ref nums i) add1 0)))

        (define (find-max-two freq)
          (let loop ([keys (hash-keys freq)]
                     [max1 0]
                     [max2 0]
                     [val1 0]
                     [val2 0])
            (cond
              [(null? keys) (values val1 val1 val2 val2)]
              [else 
               (let ([key (car keys)]
                     [value (hash-ref freq key)])
                 (cond
                   [(> value max1) (loop (cdr keys) value max1 key val1)]
                   [(> value max2) (loop (cdr keys) max1 value val1 key)]
                   [else (loop (cdr keys) max1 max2 val1 val2)]))]))
            )

        (let-values ([(even-max1 even-val1 even-max2 even-val2) (find-max-two even-freq)])
          (let-values ([(odd-max1 odd-val1 odd-max2 odd-val2) (find-max-two odd-freq)])
            (if (not (= even-val1 odd-val1))
                (- n (+ even-max1 odd-max1))
                (- n (max (+ even-max1 odd-max2) (+ even-max2 odd-max1)))))))))