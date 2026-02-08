(define (min-operations nums)
  (let loop ((current-flip-count 0)
             (operations 0)
             (nums-list nums))
    (if (null? nums-list)
        operations
        (let* ((num (car nums-list))
               (effective-value (if (even? current-flip-count)
                                    num
                                    (- 1 num))))
          (if (= effective-value 0)
              (loop (+ current-flip-count 1)
                    (+ operations 1)
                    (cdr nums-list))
              (loop current-flip-count
                    operations
                    (cdr nums-list)))))))