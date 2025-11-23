#lang racket

(define (find-largest-almost-missing-integer nums)
  (if (empty? nums)
      -1
      (let* ([num-set (list->set nums)]
             [max-val (apply max nums)])
        (let loop ([k (+ max-val 1)])
          (cond
            [(= k 0) -1]
            [(and (not (set-contains? num-set k))
                  (set-contains? num-set (- k 1)))
             k]
            [else (loop (- k 1))])))))