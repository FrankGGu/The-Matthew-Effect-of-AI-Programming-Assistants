(require srfi/1)

(define (make-array-strictly-increasing arr1 arr2)
  (define N (length arr1))

  (define sorted-arr2 (list->vector (sort (remove-duplicates arr2) <)))
  (define M (vector-length sorted-arr2))

  (define (lower-bound vec target)
    (let loop ([low 0] [high (vector-length vec)])
      (if (= low high)
          low
          (let ([mid (quotient (+ low high) 2)])
            (if (< (vector-ref vec mid) target)
                (loop (+ mid 1) high)
                (loop low mid)))))))

  (define (find-next-greater val)
    (let ([idx (lower-bound sorted-arr2 (+ val 1))])
      (if (< idx M)
          (vector-ref sorted-arr2 idx)
          +inf.0)))

  (define dp (make-hash))
  (hash-set! dp 0 -1)

  (for-each (lambda (x)
              (define new-dp (make-hash))

              (hash-for-each
               dp
               (lambda (ops prev-val)
                 (when (not (= prev-val +inf.0))
                   (when (> x prev-val)
                     (hash-update! new-dp ops (lambda (current-min) (min current-min x)) +inf.0))

                   (let ([next-val-from-arr2 (find-next-greater prev-val)])
                     (when (not (= next-val-from-arr2 +inf.0))
                       (hash-update! new-dp (+ ops 1) (lambda (current-min) (min current-min next-val-from-arr2)) +inf.0))))))

              (set! dp new-dp))
            arr1)

  (let ([min-ops +inf.0])
    (hash-for-each
     dp
     (lambda (ops last-val)
       (when (not (= last-val +inf.0))
         (set! min-ops (min min-ops ops)))))

    (if (= min-ops +inf.0)
        -1
        min-ops)))