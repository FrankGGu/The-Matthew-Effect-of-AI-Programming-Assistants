#lang racket

(define (get-square-free-part n)
  (let loop ((num n) (d 2))
    (if (> (* d d) num)
        num
        (if (zero? (modulo num (* d d)))
            (let div-by-d-squared ((current-num num))
              (if (zero? (modulo current-num (* d d)))
                  (div-by-d-squared (/ current-num (* d d)))
                  (loop current-num (+ d 1))))
            (loop num (+ d 1))))))

(define (maximum-element-sum-of-complete-subset-of-indices nums)
  (let* ((n (vector-length nums))
         (max-sum (if (> n 0) (vector-ref nums 0) 0))
         (sf-sums (make-hash)))

    (for ((i (in-range 1 n)))
      (let* ((sf (get-square-free-part i))
             (current-sum (hash-ref sf-sums sf 0))
             (new-sum (+ current-sum (vector-ref nums i))))
        (hash-set! sf-sums sf new-sum)
        (set! max-sum (max max-sum new-sum))))

    max-sum))