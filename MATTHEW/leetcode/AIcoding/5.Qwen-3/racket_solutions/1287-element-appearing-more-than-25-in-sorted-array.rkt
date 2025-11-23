#lang racket

(define (is-possible nums target)
  (let loop ([i 0] [count 0])
    (cond [(= i (length nums)) #f]
          [(= (list-ref nums i) target) (loop (+ i 1) (+ count 1))]
          [else (loop (+ i 1) 0)])))

(define (find-in-array nums)
  (let ([n (length nums)])
    (let loop ([i 0])
      (when (< i n)
        (if (is-possible nums (list-ref nums i))
            (list-ref nums i)
            (loop (+ i 1)))))))

(define (find-element nums)
  (let ([n (length nums)])
    (if (< n 4) (list-ref nums 0)
        (let ([target1 (list-ref nums (floor (/ n 4)))]
              [target2 (list-ref nums (floor (* 2 n 1/4)))]
              [target3 (list-ref nums (floor (* 3 n 1/4)))]
              [target4 (list-ref nums (floor (* 4 n 1/4)))]
              [target5 (list-ref nums (floor (* 5 n 1/4)))]
              [target6 (list-ref nums (floor (* 6 n 1/4)))]
              [target7 (list-ref nums (floor (* 7 n 1/4)))]
              [target8 (list-ref nums (floor (* 8 n 1/4)))])
          (if (is-possible nums target1) target1
              (if (is-possible nums target2) target2
                  (if (is-possible nums target3) target3
                      (if (is-possible nums target4) target4
                          (if (is-possible nums target5) target5
                              (if (is-possible nums target6) target6
                                  (if (is-possible nums target7) target7
                                      (if (is-possible nums target8) target8
                                          (find-in-array nums))))))))))))

(define (element-appearing-more-than-25%-in-sorted-array nums)
  (find-element nums))