#lang racket

(define (max-sum-of-three-subarrays nums k)
  (define n (length nums))
  (define nums-vec (list->vector nums))

  (define W-len (- n k -1))
  (define W (make-vector W-len))

  (let ((current-sum 0))
    (for ((idx (in-range k)))
      (set! current-sum (+ current-sum (vector-ref nums-vec idx))))
    (vector-set! W 0 current-sum)
    (for ((i (in-range 1 W-len)))
      (set! current-sum
            (- (+ current-sum (vector-ref nums-vec (+ i k -1)))
               (vector-ref nums-vec (- i 1))))
      (vector-set! W i current-sum)))

  (define left (make-vector W-len))
  (vector-set! left 0 0)
  (for ((i (in-range 1 W-len)))
    (if (> (vector-ref W i) (vector-ref W (vector-ref left (- i 1))))
        (vector-set! left i i)
        (vector-set! left i (vector-ref left (- i 1)))))

  (define right (make-vector W-len))
  (vector-set! right (- W-len 1) (- W-len 1))
  (for ((i (in-range (- W-len 2) -1 -1)))
    (if (>= (vector-ref W i) (vector-ref W (vector-ref right (+ i 1))))
        (vector-set! right i i)
        (vector-set! right i (vector-ref right (+ i 1)))))

  (define max-sum 0)
  (define result (vector 0 0 0))

  (define start-j k)
  (define end-j (- n (* 2 k)))

  (for ((j (in-range start-j (+ end-j 1))))
    (define left-idx (vector-ref left (- j k)))
    (define right-idx (vector-ref right (+ j k)))
    (define current-total-sum (+ (vector-ref W left-idx)
                                 (vector-ref W j)
                                 (vector-ref W right-idx)))

    (when (> current-total-sum max-sum)
      (set! max-sum current-total-sum)
      (vector-set! result 0 left-idx)
      (vector-set! result 1 j)
      (vector-set! result 2 right-idx)))

  (vector->list result))