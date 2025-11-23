(define (largest-component-size nums)
  (if (null? nums)
      0 ; Handle empty list case
      (let ()
        (define parent (make-hash)) ; Maps element to its parent

        ; Finds the root of x, with path compression.
        ; Initializes x if it's not yet in the parent hash.
        (define (find x)
          (unless (hash-has-key? parent x)
            (hash-set! parent x x)) ; Initialize x as its own parent
          (let ([p (hash-ref parent x)])
            (if (= p x)
                x
                (let ([root (find p)])
                  (hash-set! parent x root) ; Path compression
                  root))))

        ; Unites the sets containing x and y.
        (define (union x y)
          (let ([root-x (find x)]
                [root-y (find y)])
            (unless (= root-x root-y)
              (hash-set! parent root-y root-x)))) ; Arbitrarily make root-x the parent

        ; Helper to get unique prime factors of a number n.
        ; Assumes n > 1.
        (define (get-prime-factors n)
          (define factors '())
          (define d 2)
          (define temp-n n)
          (while (and (<= (* d d) temp-n) (> temp-n 1))
            (when (= (remainder temp-n d) 0)
              (set! factors (cons d factors)) ; Add prime factor
              (while (= (remainder temp-n d) 0) ; Remove all occurrences of this factor
                (set! temp-n (/ temp-n d))))
            (set! d (+ d 1)))
          (when (> temp-n 1) ; If temp-n is still > 1, it's a prime factor itself
            (set! factors (cons temp-n factors)))
          factors)

        ; Initialize parent for all numbers in nums.
        (for-each (lambda (num) (find num)) nums)

        ; For each number in nums, connect it to all its prime factors.
        (for-each (lambda (num)
                    (when (> num 1) ; Numbers <= 1 do not contribute to common factors > 1
                      (let ([factors (get-prime-factors num)])
                        (for-each (lambda (p)
                                    (union num p)) factors))))
                  nums)

        ; Count the size of each component based on original numbers from 'nums'.
        (define component-member-counts (make-hash)) ; Maps root -> count of original 'nums' elements in its component

        (for-each (lambda (num)
                    (let ([root (find num)])
                      (hash-set! component-member-counts root (+ (hash-ref component-member-counts root 0) 1))))
                  nums)

        ; Find the maximum count.
        (apply max (hash-values component-member-counts))))
  )