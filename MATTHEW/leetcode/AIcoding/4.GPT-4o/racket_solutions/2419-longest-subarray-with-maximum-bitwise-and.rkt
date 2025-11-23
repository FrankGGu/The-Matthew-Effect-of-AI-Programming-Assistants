(define (longest-subarray nums)
  (define max-val (apply max nums))
  (define (length-of-subarray lst)
    (let loop ((lst lst) (count 0) (max-count 0))
      (cond
        ((null? lst) max-count)
        ((= (car lst) max-val) (loop (cdr lst) (+ count 1) (max max-count (+ count 1)))
        (else (loop (cdr lst) 0 max-count)))))
  (length-of-subarray nums))