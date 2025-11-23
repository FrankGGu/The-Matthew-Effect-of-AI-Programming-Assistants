(define (subarrays-with-k-nice nums k)
  (define (is-nice? nums)
    (let loop ([nums nums] [count 0])
      (cond [(null? nums) (= count k)]
            [(odd? (car nums)) (loop (cdr nums) (+ count 1))]
            [else (loop (cdr nums) count)])))

  (define (count-subarrays nums)
    (let loop ([start 0] [count 0])
      (if (>= start (length nums))
          count
          (let ([end (length nums)])
            (let loop2 ([end end] [current-count 0])
              (if (<= end start)
                  (loop (+ start 1) count)
                  (let ([new-count (if (odd? (list-ref nums (- end 1))) (+ current-count 1) current-count)])
                    (if (= new-count k)
                        (loop2 (- end 1) new-count)
                        (loop2 (- end 1) new-count)))))))))

  (count-subarrays nums))

(define (num-of-nice-subarrays nums k)
  (subarrays-with-k-nice nums k))