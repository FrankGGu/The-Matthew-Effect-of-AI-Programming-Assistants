(define (make-array-increasing arr1 arr2)
  (define (helper prev arr1 arr2 index)
    (if (>= index (length arr1))
        0
        (let loop ((min-changes +inf.0) (i 0))
          (if (>= i (length arr2))
              (if (> prev (list-ref arr1 index))
                  +inf.0
                  (helper (list-ref arr1 index) arr1 arr2 (+ index 1)))
              (let ((new-val (list-ref arr2 i)))
                (if (> new-val prev)
                    (loop (min min-changes (helper new-val arr1 arr2 (+ index 1)))
                          (+ i 1))
                    (loop min-changes (+ i 1)))))))
  (define arr2-sorted (sort arr2 <))
  (let ((result (helper -inf.0 arr1 arr2-sorted 0)))
    (if (= result +inf.0) -1 result)))

(define (main) (make-array-increasing '(1 5 3 6 7) '(1 3 2 4)))