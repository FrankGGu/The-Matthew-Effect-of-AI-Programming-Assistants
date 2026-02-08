(define (shortest-subarray-with-sum-at-least-k nums k)
  (define n (length nums))
  (define pref (make-vector (+ n 1) 0))
  (for/fold ([i 0]
             [res 0])
            ([num (in-list nums)])
    (vector-set! pref (+ i 1) (+ (vector-ref pref i) num))
    (values (+ i 1) res))

  (define dq (list))
  (define ans (+ n 1))

  (for ([i (in-range (+ n 1))])
    (begin
      (while (and (not (empty? dq)) (>= (- (vector-ref pref i) (vector-ref pref (car dq))) k))
        (set! ans (min ans (- i (car dq))))
        (set! dq (cdr dq)))

      (while (and (not (empty? dq)) (<= (vector-ref pref i) (vector-ref pref (last dq))))
        (set! dq (drop-right dq 1)))

      (set! dq (append dq (list i)))))

  (if (= ans (+ n 1))
      -1
      ans))