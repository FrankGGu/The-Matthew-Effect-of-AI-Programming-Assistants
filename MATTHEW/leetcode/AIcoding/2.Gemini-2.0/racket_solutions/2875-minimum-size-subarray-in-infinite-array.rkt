(define (minSubarray nums target)
  (define n (length nums))
  (define total-sum (apply + nums))
  (define num-repeats (max 0 (floor (/ target total-sum))))
  (define remaining-target (- target (* num-repeats total-sum)))
  (define (find-min-subarray arr target)
    (define m (length arr))
    (define (helper left right current-sum min-len)
      (cond
        [(> left right) min-len]
        [(>= current-sum target)
         (helper (add1 left) right (- current-sum (list-ref arr left)) (min min-len (- right left 1)))]
        [(< right (sub1 m))
         (helper left (add1 right) (+ current-sum (list-ref arr right)) min-len)]
        [else min-len]))
    (helper 0 0 (list-ref arr 0) (+ m 1)))
  (if (zero? total-sum)
      (if (zero? target) 0 -1)
      (let* ([extended-nums (append nums nums)]
             [min-len (find-min-subarray extended-nums remaining-target)])
        (if (= min-len (+ (length extended-nums) 1))
            -1
            (+ min-len (* num-repeats n))))))