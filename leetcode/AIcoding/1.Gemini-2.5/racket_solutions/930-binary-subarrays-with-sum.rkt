#lang racket

(define (num-subarrays-with-sum nums goal)
  (define-values (final-current-sum final-count final-prefix-sum-counts)
    (for/fold ([current-sum 0]
               [count 0]
               [prefix-sum-counts (hash 0 1)]) ; Initialize with prefix sum 0 occurring once
              ([num nums])
      (define new-current-sum (+ current-sum num))
      (define target-prefix-sum (- new-current-sum goal))
      (define new-count (+ count (hash-ref prefix-sum-counts target-prefix-sum 0)))
      (define new-prefix-sum-counts (hash-update prefix-sum-counts new-current-sum add1 0))
      (values new-current-sum new-count new-prefix-sum-counts)))
  final-count)