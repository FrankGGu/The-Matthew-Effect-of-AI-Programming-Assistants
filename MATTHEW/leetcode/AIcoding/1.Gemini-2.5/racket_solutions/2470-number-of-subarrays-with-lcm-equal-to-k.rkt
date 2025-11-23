#lang racket

(define (gcd a b)
  (if (zero? b)
      a
      (gcd b (modulo a b))))

(define (lcm a b)
  (/ (* a b) (gcd a b)))

(define (number-of-subarrays-with-lcm-equal-to-k nums k)
  (let* ((n (length nums))
         (count 0))
    (for ((i (in-range n)))
      (let ((current-lcm 1))
        (for ((j (in-range i n)))
          (let ((num-j (list-ref nums j)))
            (when (not (zero? (modulo k num-j)))
              (break))
            (set! current-lcm (lcm current-lcm num-j))
            (when (> current-lcm k)
              (break))
            (when (= current-lcm k)
              (set! count (+ count 1)))))))
    count))