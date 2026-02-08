(define (can-arrange arr k)
  (and (even? (length arr)) ; 1. Array length must be even
       (let ((counts (make-hash)))
         ;; Populate counts of remainders
         (for-each (lambda (num)
                     (let ((rem (modulo num k)))
                       (hash-set! counts rem (+ (hash-ref counts rem 0) 1))))
                   arr)

         ;; 2. Count of remainder 0 must be even
         (and (even? (hash-ref counts 0 0))
              ;; 3. Check pairs of remainders (r, k-r)
              ;;    Use a named let for the loop to return #f on mismatch
              (let loop ((r 1))
                (if (> r (quotient k 2)) ; Loop from 1 up to floor(k/2)
                    #t ; All checks passed
                    (let ((count-r (hash-ref counts r 0)))
                      (if (= r (- k r)) ; This means r is k/2 and k is even
                          (if (even? count-r)
                              (loop (+ r 1))
                              #f) ; Count of k/2 must be even
                          ;; r != k-r
                          (let ((count-k-r (hash-ref counts (- k r) 0)))
                            (if (= count-r count-k-r)
                                (loop (+ r 1))
                                #f)))))))))) ; Remainder counts do not match