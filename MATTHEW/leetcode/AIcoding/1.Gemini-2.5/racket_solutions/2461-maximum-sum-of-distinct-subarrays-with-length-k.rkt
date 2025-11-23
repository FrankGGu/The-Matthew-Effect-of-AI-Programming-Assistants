#lang racket

(define (maximum-sum-of-distinct-subarrays-with-length-k nums k)
  (define n (length nums))
  (define max-sum 0)
  (define current-sum 0)
  (define counts (make-hash)) ; Stores frequency of numbers in current window

  (define left 0)

  (for ([right (in-range n)])
    (define num-right (list-ref nums right))

    ;; Add current element to window
    (set! current-sum (+ current-sum num-right))
    (hash-table-update! counts num-right add1 (lambda () 0))

    ;; Check if window size is k
    (when (>= (add1 right) k)
      ;; If window has k distinct elements, update max-sum
      (when (= (hash-table-count counts) k)
        (set! max-sum (max max-sum current-sum)))

      ;; Slide window: remove leftmost element
      (define num-left (list-ref nums left))
      (set! current-sum (- current-sum num-left))
      (hash-table-update! counts num-left sub1)
      (when (= (hash-table-ref counts num-left) 0)
        (hash-table-remove! counts num-left))
      (set! left (add1 left))))

  max-sum)