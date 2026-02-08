(define (make-array-non-decreasing nums)
  (if (null? nums)
      0
      (let loop ((lst (cdr nums))
                 (prev (car nums))
                 (ops 0))
        (if (null? lst)
            ops
            (let ((current (car lst)))
              (if (< current prev)
                  (let ((diff (- prev current)))
                    (loop (cdr lst) prev (+ ops diff)))
                  (loop (cdr lst) current ops)))))))