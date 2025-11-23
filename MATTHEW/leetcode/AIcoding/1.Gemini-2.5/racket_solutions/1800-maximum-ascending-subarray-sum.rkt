(define (max-ascending-subarray-sum nums)
  (if (empty? nums)
      0
      (let loop ((rest (cdr nums))
                 (current-sum (car nums))
                 (max-so-far (car nums))
                 (prev (car nums)))
        (if (empty? rest)
            max-so-far
            (let* ((current (car rest))
                   (new-current-sum (if (> current prev)
                                        (+ current-sum current)
                                        current))
                   (new-max-so-far (max max-so-far new-current-sum)))
              (loop (cdr rest)
                    new-current-sum
                    new-max-so-far
                    current))))))