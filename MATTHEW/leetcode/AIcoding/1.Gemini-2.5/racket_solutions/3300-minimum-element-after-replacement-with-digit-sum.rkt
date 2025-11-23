(define (digital-root n)
  (if (= n 0)
      0
      (let ((remainder (modulo n 9)))
        (if (= remainder 0)
            9
            remainder))))

(define (minimum-element-after-replacement-with-digit-sum nums)
  (let ((transformed-nums (map digital-root nums)))
    (apply min transformed-nums)))