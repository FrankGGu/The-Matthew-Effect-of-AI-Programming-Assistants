(define (maximumStrongPairXor nums)
  (let loop ((nums nums) (max-xor 0))
    (if (null? nums)
        max-xor
        (let* ((current (car nums))
               (new-max-xor (apply max max-xor (map (lambda (x) (xor current x)) nums))))
               (next (cdr nums)))
          (loop next new-max-xor)))))

(define (maximumXor nums)
  (maximumStrongPairXor nums))