(define (count-tested-devices devices test_operations)
  (define (update-device-status devices test)
    (for/fold ([new-devices devices]) ([op test])
      (let ([index (car op)]
            [status (cadr op)])
        (list-set new-devices index status))))

  (define updated-devices (foldl update-device-status devices test_operations))
  (length (filter (lambda (x) (= x 1)) updated-devices)))

(count-tested-devices '(0 0 0 0) '((0 1) (1 1) (2 0) (3 1)))