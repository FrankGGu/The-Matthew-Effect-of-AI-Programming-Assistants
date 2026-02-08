(define (satisfies-pattern num1 num2 pat-val)
  (cond
    [(= pat-val 0) (= num1 num2)]
    [(= pat-val 1) (> num2 num1)]
    [(= pat-val -1) (< num2 num1)]))

(define (check-subarray nums-sub pattern)
  (let loop ([current-nums-segment nums-sub]
             [current-pattern-segment pattern])
    (if (null? current-pattern-segment)
        #t
        (let* ([num1 (car current-nums-segment)]
               [num2 (cadr current-nums-segment)]
               [pat-val (car current-pattern-segment)])
          (if (satisfies-pattern num1 num2 pat-val)
              (loop (cdr current-nums-segment) (cdr current-pattern-segment))
              #f)))))

(define (count-matching-subarrays nums pattern)
  (let* ([n (length nums)]
         [m (length pattern)]
         [target-subarray-len (+ m 1)])
    (if (< n target-subarray-len)
        0
        (let loop ([current-nums-head nums]
                   [remaining-elements n]
                   [count 0])
          (if (< remaining-elements target-subarray-len)
              count
              (let ([sub-list-to-check (take current-nums-head target-subarray-len)])
                (if (check-subarray sub-list-to-check pattern)
                    (loop (cdr current-nums-head) (- remaining-elements 1) (+ count 1))
                    (loop (cdr current-nums-head) (- remaining-elements 1) count))))))))