(define (find-subarrays-with-equal-sum nums)
  (let loop ((idx 0) (seen-sums (make-hash)))
    (if (>= (+ idx 1) (length nums))
        #f
        (let* ((num1 (list-ref nums idx))
               (num2 (list-ref nums (+ idx 1)))
               (current-sum (+ num1 num2)))
          (if (hash-has-key? seen-sums current-sum)
              #t
              (begin
                (hash-set! seen-sums current-sum #t)
                (loop (+ idx 1) seen-sums)))))))