#lang racket

(define (triangle-number nums)
  (define (count-triangle nums)
    (define len (length nums))
    (if (< len 3) 0
        (let loop ((i (- len 1)) (count 0))
          (if (< i 2) count
              (let ((j 0) (k (- i 1)))
                (let inner-loop ()
                  (when (<= j k)
                    (when (<= (+ (list-ref nums j) (list-ref nums k)) (list-ref nums i))
                      (set! count (+ count (- k j))))
                    (if (<= (+ (list-ref nums j) (list-ref nums k)) (list-ref nums i))
                        (set! j (+ j 1))
                        (set! k (- k 1)))
                    (inner-loop)))
                (loop (- i 1) count))))))
  (define sorted (sort nums <))
  (count-triangle sorted))

(define/contract (valid-triangle-number nums)
  (-> (listof exact-integer?) exact-integer?)
  (triangle-number nums))