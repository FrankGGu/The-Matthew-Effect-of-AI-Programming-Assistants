#lang racket

(define MOD 1000000007)

(define (lower-bound vec target)
  (let* ([len (vector-length vec)]
         [low 0]
         [high len])
    (let loop ([l low] [h high])
      (if (= l h)
          l
          (let ([mid (+ l (quotient (- h l) 2))])
            (if (< (vector-ref vec mid) target)
                (loop (+ mid 1) h)
                (loop l mid)))))))

(define (upper-bound vec target)
  (let* ([len (vector-length vec)]
         [low 0]
         [high len])
    (let loop ([l low] [h high])
      (if (= l h)
          l
          (let ([mid (+ l (quotient (- h l) 2))])
            (if (<= (vector-ref vec mid) target)
                (loop (+ mid 1) h)
                (loop l mid)))))))

(define (minimum-space-wasted-from-packaging packages boxes)
  (let* ([sorted-packages (vector-sort < (list->vector packages))]
         [num-packages (vector-length sorted-packages)]
         [total-package-sum (for/sum ([p (in-vector sorted-packages)]) p)]
         [min-total-waste +inf.0]) ; Initialize with positive infinity

    ;; Iterate through each supplier's boxes
    (for ([supplier-boxes-list (in-list boxes)])
      (let* ([sorted-supplier-boxes (vector-sort < (list->vector supplier-boxes-list))]
             [num-supplier-boxes (vector-length sorted-supplier-boxes)]
             [current-supplier-box-sum 0]
             [package-idx 0] ; Pointer to the first package not yet covered
             [possible-supplier #t])

        ;; Iterate through each box size offered by the current supplier
        (for ([box-idx (in-range num-supplier-boxes)])
          (let ([current-box-size (vector-ref sorted-supplier-boxes box-idx)])
            ;; Find the index of the first package that is strictly greater than current-box-size.
            ;; All packages from package-idx up to (exclusive) next-package-idx fit into current-box-size.
            (let ([next-package-idx (upper-bound sorted-packages current-box-size)])

              ;; If this box covers new packages (i.e., next-package-idx has advanced beyond package-idx)
              (when (> next-package-idx package-idx)
                (set! current-supplier-box-sum
                      (+ current-supplier-box-sum
                         (* current-box-size (- next-package-idx package-idx))))
                ;; Advance package-idx to the first package not yet covered
                (set! package-idx next-package-idx)))))

        ;; After checking all boxes from this supplier, verify if all packages were covered
        (when (< package-idx num-packages)
          (set! possible-supplier #f))

        ;; If this supplier can fulfill all packages, calculate its waste and update min-total-waste
        (when possible-supplier
          (set! min-total-waste
                (min min-total-waste
                     (- current-supplier-box-sum total-package-sum))))))

    ;; If no supplier could fulfill the order, return -1.
    ;; Otherwise, return the minimum waste modulo MOD.
    (if (= min-total-waste +inf.0)
        -1
        (modulo min-total-waste MOD))))