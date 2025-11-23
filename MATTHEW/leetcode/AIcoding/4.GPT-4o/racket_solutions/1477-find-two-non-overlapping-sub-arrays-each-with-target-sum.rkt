(define (min-sum-of-two-subarrays arr target)
  (define n (length arr))
  (define (find-subarrays target)
    (let loop ((start 0) (sum 0) (sums '()) (results '()))
      (if (>= start n)
          results
          (let ((sum (+ sum (list-ref arr start))))
            (if (= sum target)
                (loop (+ start 1) (if (> start 0) (list-ref arr (- start 1)) 0) (cons start sums) (cons start results))
                (if (> sum target)
                    (loop (+ start 1) (if (> start 0) (list-ref arr (- start 1)) 0) (cdr sums) (if (null? sums) results (cons (car sums) results)))
                    (loop (+ start 1) sum (cons start sums) results)))))))

  (define subarrays (find-subarrays target))
  (define (compute-min-length subarr)
    (if (null? subarr)
        +inf.0
        (apply min (map (lambda (x) (if (null? x) +inf.0 (length x))) subarr))))

  (define min-length (compute-min-length subarrays))
  (if (= min-length +inf.0)
      -1
      min-length))

(define (min-sum-of-two-non-overlapping-subarrays arr target)
  (let ((min-length (min-sum-of-two-subarrays arr target)))
    (if (= min-length -1)
        -1
        (let loop ((i 0) (res +inf.0) (first-sums '()))
          (if (>= i (length arr))
              (if (= res +inf.0) -1 res)
              (let ((first (min-sum-of-two-subarrays (subvector arr 0 i) target)))
                (if (and (not (= first -1)) (not (= (min-sum-of-two-subarrays (subvector arr (+ i 1) (length arr)) target) -1)))
                    (loop (+ i 1) (min res (+ first (min-sum-of-two-subarrays (subvector arr (+ i 1) (length arr)) target))) first-sums)
                    (loop (+ i 1) res first-sums)))))))