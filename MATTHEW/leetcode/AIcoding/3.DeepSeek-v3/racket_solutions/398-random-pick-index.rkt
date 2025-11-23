(define pick-index
  (let ([h (make-hash)])
    (lambda (nums)
      (hash-clear! h)
      (for ([num (in-list nums)]
            [i (in-naturals)])
        (hash-update! h num (lambda (lst) (cons i lst)) '()))
      (lambda (target)
        (let ([lst (hash-ref h target)])
          (list-ref lst (random (length lst))))))))