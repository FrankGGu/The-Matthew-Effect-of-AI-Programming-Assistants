(define (maximum-difference nums)
  (let loop ((rest (cdr nums))
             (min-so-far (car nums))
             (max-diff -1))
    (if (empty? rest)
        max-diff
        (let ((current-num (car rest)))
          (if (> current-num min-so-far)
              (loop (cdr rest)
                    min-so-far
                    (max max-diff (- current-num min-so-far)))
              (loop (cdr rest)
                    current-num
                    max-diff))))))