(define (find-unsorted-subarray nums)
  (define n (length nums))
  (if (zero? n)
      0
      (begin
        (define sorted-nums (list-sort < nums))
        (define left n)
        (define right -1)

        (let find-left ((i 0))
          (cond
            ((= i n) ; Reached end, no mismatch
             (set! left n))
            ((not (= (list-ref nums i) (list-ref sorted-nums i))) ; First mismatch found
             (set! left i))
            (else ; No mismatch yet, continue
             (find-left (+ i 1)))))

        (let find-right ((i (- n 1)))
          (cond
            ((< i 0) ; Reached beginning, no mismatch
             (set! right -1))
            ((not (= (list-ref nums i) (list-ref sorted-nums i))) ; First mismatch found
             (set! right i))
            (else ; No mismatch yet, continue
             (find-right (- i 1)))))

        (if (<= left right)
            (+ (- right left) 1)
            0))))