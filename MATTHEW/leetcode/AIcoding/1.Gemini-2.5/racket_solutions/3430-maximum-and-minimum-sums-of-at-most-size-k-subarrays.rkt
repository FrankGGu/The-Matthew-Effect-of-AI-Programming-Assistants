#lang racket

(define-syntax-rule (while test body ...)
  (let loop ()
    (when test
      body ...
      (loop))))

(define (maximum-and-minimum-sums-of-at-most-size-k-subarrays nums k)
  (let* ([n (vector-length nums)])
    ;; Problem constraints usually guarantee n >= 1
    (when (= n 0)
      (error "nums cannot be empty"))

    ;; Deque implementation using mcons for mutable pairs (front-list . back-list)
    (define (make-deque) (mcons '() '()))
    (define (deque-empty? dq) (and (null? (car dq)) (null? (cdr dq))))

    (define (deque-front dq)
      (if (null? (car dq))
          (if (null? (cdr dq)) (error "deque-front: empty deque") (car (reverse (cdr dq))))
          (car (car dq))))

    (define (deque-back dq)
      (if (null? (cdr dq))
          (if (null? (car dq)) (error "deque-back: empty deque") (car (reverse (car dq))))
          (car (cdr dq))))

    (define (deque-push-back! dq item) (set-cdr! dq (cons item (cdr dq))))

    (define (deque-pop-front! dq)
      (if (null? (car dq))
          (if (null? (cdr dq))
              (error "deque-pop-front!: empty deque")
              (begin (set-car! dq (reverse (cdr dq)))
                     (set-cdr! dq '())
                     (let ([item (car (car dq))])
                       (set-car! dq (cdr (car dq)))
                       item)))
          (let ([item (car (car dq))])
            (set-car! dq (cdr (car dq)))
            item)))

    (define (deque-pop-back! dq)
      (if (null? (cdr dq))
          (if (null? (car dq))
              (error "deque-pop-back!: empty deque")
              (begin (set-cdr! dq (reverse (car dq)))
                     (set-car! dq '())
                     (let ([item (car (cdr dq))])
                       (set-cdr! dq (cdr (cdr dq)))
                       item)))
          (let ([item (car (cdr dq))])
            (set-cdr! dq (cdr (cdr dq)))
            item)))

    (let ([prefix-sum-values (make-vector (+ n 1))]
          [max-sum-val (- +inf.0)]
          [min-sum-val +inf.0])

      ;; Calculate prefix sums
      (vector-set! prefix-sum-values 0 0)
      (let loop-prefix ([i 0] [current-sum 0])
        (when (< i n)
          (let ([new-sum (+ current-sum (vector-ref nums i))])
            (vector-set! prefix-sum-values (+ i 1) new-sum)
            (loop-prefix (+ i 1) new-sum))))

      ;; Initialize max-sum-val and min-sum-val with the largest/smallest single element
      (set! max-sum-val (vector-ref nums 0))
      (set! min-sum-val (vector-ref nums 0))
      (let loop-init-min-max ([i 1])
        (when (< i n)
          (set! max-sum-val (max max-sum-val (vector-ref nums i)))
          (set! min-sum-val (min min-sum-val (vector-ref nums i)))
          (loop-init-min-max (+ i 1))))

      ;; Calculate maximum sum using a monotonic deque (stores indices for minimum prefix sum in window)
      (let ([deque-max (make-deque)])
        (deque-push-back! deque-max 0) ; Add index 0 for P[0]
        (let loop-max ([j 0])
          (when (< j n)
            (let ([current-prefix-sum (vector-ref prefix-sum-values (+ j 1))])
              ;; Remove indices from front of deque-max that are out of window
              (while (and (not (deque-empty? deque-max)) (< (deque-front deque-max) (- (+ j 1) k)))
                (deque-pop-front! deque-max))

              ;; Calculate max sum ending at j (using P[j+1] - P[i])
              (set! max-sum-val (max max-sum-val (- current-prefix-sum (vector-ref prefix-sum-values (deque-front deque-max)))))

              ;; Maintain deque-max such that prefix_sum_values at these indices are increasing
              (while (and (not (deque-empty? deque-max)) (>= (vector-ref prefix-sum-values (deque-back deque-max)) current-prefix-sum))
                (deque-pop-back! deque-max))

              (deque-push-back! deque-max (+ j 1)))
            (loop-max (+ j 1)))))

      ;; Calculate minimum sum using a monotonic deque (stores indices for maximum prefix sum in window)
      (let ([deque-min (make-deque)])
        (deque-push-back! deque-min 0) ; Add index 0 for P[0]
        (let loop-min ([j 0])
          (when (< j n)
            (let ([current-prefix-sum (vector-ref prefix-sum-values (+ j 1))])
              ;; Remove indices from front of deque-min that are out of window
              (while (and (not (deque-empty? deque-min)) (< (deque-front deque-min) (- (+ j 1) k)))
                (deque-pop-front! deque-min))

              ;; Calculate min sum ending at j (using P[j+1] - P[i])
              (set! min-sum-val (min min-sum-val (- current-prefix-sum (vector-ref prefix-sum-values (deque-front deque-min)))))

              ;; Maintain deque-min such that prefix_sum_values at these indices are decreasing
              (while (and (not (deque-empty? deque-min)) (<= (vector-ref prefix-sum-values (deque-back deque-min)) current-prefix-sum))
                (deque-pop-back! deque-min))

              (deque-push-back! deque-min (+ j 1)))
            (loop-min (+ j 1)))))

      (list max-sum-val min-sum-val))))