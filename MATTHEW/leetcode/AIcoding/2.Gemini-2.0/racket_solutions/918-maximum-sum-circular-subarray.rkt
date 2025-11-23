(define (max-subarray arr)
  (let ((n (length arr)))
    (if (= n 0)
        0
        (let loop ((i 1) (max-so-far (list-ref arr 0)) (current-max (list-ref arr 0)))
          (if (= i n)
              max-so-far
              (let ((val (list-ref arr i)))
                (let ((new-current-max (max val (+ current-max val))))
                  (loop (+ i 1) (max max-so-far new-current-max) new-current-max))))))))

(define (min-subarray arr)
  (let ((n (length arr)))
    (if (= n 0)
        0
        (let loop ((i 1) (min-so-far (list-ref arr 0)) (current-min (list-ref arr 0)))
          (if (= i n)
              min-so-far
              (let ((val (list-ref arr i)))
                (let ((new-current-min (min val (+ current-min val))))
                  (loop (+ i 1) (min min-so-far new-current-min) new-current-min))))))))

(define (max-subarray-circular arr)
  (let ((n (length arr)))
    (if (= n 0)
        0
        (let ((max-normal (max-subarray arr))
              (arr-sum (apply + arr)))
          (if (= max-normal arr-sum)
              (if (equal? (sort arr <) (make-list n 0))
                  max-normal
                  (max max-normal (- arr-sum (min-subarray arr))))
              (max max-normal (- arr-sum (min-subarray arr))))))))