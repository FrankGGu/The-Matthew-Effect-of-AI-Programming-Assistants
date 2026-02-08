(define (partition-array-according-to-given-pivot nums pivot)
  (let loop ((remaining-nums nums)
             (less-than-acc '())
             (equal-to-acc '())
             (greater-than-acc '()))
    (cond
      ((empty? remaining-nums)
       (append (reverse less-than-acc)
               (reverse equal-to-acc)
               (reverse greater-than-acc)))
      (else
       (let ((current-num (first remaining-nums)))
         (cond
           ((< current-num pivot)
            (loop (rest remaining-nums) (cons current-num less-than-acc) equal-to-acc greater-than-acc))
           ((= current-num pivot)
            (loop (rest remaining-nums) less-than-acc (cons current-num equal-to-acc) greater-than-acc))
           (else ; (> current-num pivot)
            (loop (rest remaining-nums) less-than-acc equal-to-acc (cons current-num greater-than-acc)))))))))