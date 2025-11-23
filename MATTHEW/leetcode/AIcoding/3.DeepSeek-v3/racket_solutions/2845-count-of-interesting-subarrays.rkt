(define (count-interesting-subarrays nums modulo k)
  (let loop ((i 0) (count 0) (sum 0) (prefix (make-hash)))
              (prefix (hash-set (hash) 0 1)))
    (if (= i (vector-length nums))
        count
        (let* ((num (vector-ref nums i))
               (sum (modulo (+ sum num) modulo))
               (target (modulo (- sum k) modulo))
               (cnt (hash-ref prefix target 0)))
          (loop (+ i 1) 
                (+ count cnt) 
                sum 
                (hash-update prefix sum add1 0))))))