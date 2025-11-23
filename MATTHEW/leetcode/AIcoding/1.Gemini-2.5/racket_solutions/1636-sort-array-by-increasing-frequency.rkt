(define (frequency-sort nums)
  (define freq-map (make-hash))

  (for-each (lambda (n)
              (hash-update! freq-map n (lambda (v) (+ v 1)) 0))
            nums)

  (sort nums (lambda (a b)
               (let ((freq-a (hash-ref freq-map a))
                     (freq-b (hash-ref freq-map b)))
                 (if (= freq-a freq-b)
                     (> a b) ; Sort by value in descending order if frequencies are equal
                     (< freq-a freq-b)))))) ; Sort by frequency in ascending order