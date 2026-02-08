#lang racket

(define (minimum-operations-to-make-array-sum-divisible-by-k nums k)
  (let* ((total-sum (foldl + 0 nums))
         (target-rem (modulo total-sum k)))

    (if (= target-rem 0)
        0
        (let ((min-len-for-rem (make-hash)))
          (hash-set! min-len-for-rem 0 0) ; 0 elements sum to 0 with length 0

          (for-each (lambda (x)
                      (let ((updates (list)))
                        ;; Collect updates to avoid modifying hash table during iteration
                        (hash-for-each
                         (lambda (rem len)
                           (let ((new-rem (modulo (+ rem x) k))
                                 (new-len (+ len 1)))
                             (set! updates (cons (cons new-rem new-len) updates))))
                         min-len-for-rem)

                        ;; Apply updates
                        (for-each (lambda (pair)
                                    (let* ((new-rem (car pair))
                                           (new-len (cdr pair))
                                           (current-len (hash-ref min-len-for-rem new-rem #f)))
                                      (when (or (not current-len) (< new-len current-len))
                                        (hash-set! min-len-for-rem new-rem new-len))))
                                  updates)))
                    nums)

          (let ((result (hash-ref min-len-for-rem target-rem #f)))
            (if result
                result
                -1))))))