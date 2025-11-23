(define (max-subarray nums)
  (define (max-subarray-helper nums current-max global-max)
    (if (null? nums)
        global-max
        (let* ((current (car nums))
               (new-current-max (max current current-max))
               (new-global-max (max new-current-max global-max)))
          (max-subarray-helper (cdr nums) new-current-max new-global-max))))
  (max-subarray-helper nums (car nums) (car nums)))