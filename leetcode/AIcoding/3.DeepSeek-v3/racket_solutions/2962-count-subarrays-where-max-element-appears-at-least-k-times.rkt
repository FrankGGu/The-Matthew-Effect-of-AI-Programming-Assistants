(define (count-subarrays nums k)
  (let* ([n (length nums)]
         [max-num (apply max nums)]
         [indices (for/list ([(num i) (in-indexed nums)] #:when (= num max-num)) i)]
         [m (length indices)]
         [result 0])
    (if (< m k)
        0
        (begin
          (for ([i (in-range 0 (- m k -1))])
            (let* ([left (if (= i 0) 0 (+ (list-ref indices (- i 1)) 1))]
                   [right (if (= (+ i k) m) (- n 1) (- (list-ref indices (+ i k)) 1))]
                   [left-count (- (list-ref indices i) left -1)]
                   [right-count (- right (list-ref indices (+ i k -1)) -1)])
              (set! result (+ result (* left-count right-count)))))
          result))))