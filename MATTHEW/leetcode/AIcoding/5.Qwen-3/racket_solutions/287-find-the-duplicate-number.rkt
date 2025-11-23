#lang racket

(define (find-duplicate nums)
  (let loop ([slow (car nums)] [fast (car nums)])
    (let ([slow (list-ref nums slow)]
          [fast (list-ref nums (list-ref nums (car nums)))])
      (if (= slow fast)
          (let loop ([slow (car nums)] [fast (car nums)])
            (if (= slow fast)
                slow
                (loop (list-ref nums slow) (list-ref nums fast))))
          (loop slow fast)))))