(define (sliding-window-maximum nums k)
  (define n (length nums))
  (if (or (null? nums) (zero? n))
      '()
      (let* ([deque (mutable-vector n)]
             [result (mutable-vector (max 0 (- n k -1)))]
             [head (mutable-box 0)]
             [tail (mutable-box 0)])

        (define (deque-empty?)
          (= (unbox head) (unbox tail)))

        (define (deque-front)
          (vector-ref deque (unbox head)))

        (define (deque-back)
          (vector-ref deque (- (unbox tail) 1)))

        (define (deque-push-back x)
          (vector-set! deque (unbox tail) x)
          (set-box! tail (+ (unbox tail) 1)))

        (define (deque-pop-back)
          (set-box! tail (- (unbox tail) 1)))

        (define (deque-pop-front)
          (set-box! head (+ (unbox head) 1)))

        (define (deque-size)
          (- (unbox tail) (unbox head)))

        (for ([i (in-range n)])
          (begin
            (while (and (not (deque-empty?))
                        (<= (vector-ref nums i) (vector-ref nums (deque-back))))
                   (deque-pop-back))

            (deque-push-back i)

            (when (<= k (- i (deque-front)))
              (deque-pop-front))

            (when (>= i (- k 1))
              (vector-set! result (- i k -1) (vector-ref nums (deque-front))))))

        (list->vector (build-list (vector-length result) (lambda (i) (vector-ref result i)))))))