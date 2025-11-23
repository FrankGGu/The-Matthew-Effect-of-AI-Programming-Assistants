(define (check-subarray-sum nums k)
  (let ((n (length nums)))
    (if (< n 2)
        #f
        (let ((remainder-map (make-hash))
              (current-sum 0))
          (hash-set! remainder-map 0 -1)
          (for/or ((i (in-range n)))
            (begin
              (set! current-sum (+ current-sum (list-ref nums i)))
              (if (not (= k 0))
                  (set! current-sum (modulo current-sum k)))
              (if (hash-has-key? remainder-map current-sum)
                  (let ((prev-index (hash-ref remainder-map current-sum)))
                    (if (> (- i prev-index) 1)
                        #t
                        #f))
                  (hash-set! remainder-map current-sum i))))))))