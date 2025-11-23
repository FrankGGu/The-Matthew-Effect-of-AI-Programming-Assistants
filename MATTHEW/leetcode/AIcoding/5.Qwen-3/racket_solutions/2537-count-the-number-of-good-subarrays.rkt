#lang racket

(define (num-subarrays-with-at-least-k-ones k nums)
  (define (count-at-least k)
    (let loop ([left 0] [right 0] [count 0] [res 0])
      (cond [(= right (length nums)) res]
            [else
             (when (= (list-ref nums right) 1)
               (set! count (+ count 1)))
             (when (>= count k)
               (set! res (+ res (- (length nums) right))))
             (loop left (+ right 1) count res)])))
  (define (count-at-most k)
    (let loop ([left 0] [right 0] [count 0] [res 0])
      (cond [(= right (length nums)) res]
            [else
             (when (= (list-ref nums right) 1)
               (set! count (+ count 1)))
             (when (> count k)
               (set! count 0)
               (set! left (+ right 1)))
             (set! res (+ res (- right left 1)))
             (loop left (+ right 1) count res)]))
  (- (count-at-least k) (count-at-most (- k 1))))

(define (num-subarrays-with-exactly-k-ones k nums)
  (define (count-at-most k)
    (let loop ([left 0] [right 0] [count 0] [res 0])
      (cond [(= right (length nums)) res]
            [else
             (when (= (list-ref nums right) 1)
               (set! count (+ count 1)))
             (when (> count k)
               (set! count 0)
               (set! left (+ right 1)))
             (set! res (+ res (- right left 1)))
             (loop left (+ right 1) count res)]))
  (if (<= k 0)
      0
      (- (count-at-most k) (count-at-most (- k 1)))))

(define (good-subarrays nums k)
  (num-subarrays-with-exactly-k-ones k nums))

(define/contract (num-subarrays-with-at-least-k-ones k nums)
  (-> exact-integer? (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [right 0] [count 0] [res 0])
    (cond [(= right (length nums)) res]
          [else
           (when (= (list-ref nums right) 1)
             (set! count (+ count 1)))
           (when (>= count k)
             (set! res (+ res (- (length nums) right))))
           (loop left (+ right 1) count res)])))

(define/contract (num-subarrays-with-exactly-k-ones k nums)
  (-> exact-integer? (listof exact-integer?) exact-integer?)
  (if (<= k 0)
      0
      (- (num-subarrays-with-at-least-k-ones k nums)
         (num-subarrays-with-at-least-k-ones (+ k 1) nums))))

(define/contract (good-subarrays nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (num-subarrays-with-exactly-k-ones k nums))

(define/contract (count-good-subarrays nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (good-subarrays nums k))