#lang racket

(define (max-groups batch-size groups)
  (define counts (make-vector batch-size 0))
  (define initial-fresh-donuts 0)

  ;; Populate counts of remainders for each group
  (for-each (lambda (g)
              (vector-set! counts (modulo g batch-size)
                           (+ (vector-ref counts (modulo g batch-size)) 1)))
            groups)

  ;; Groups with remainder 0 always get fresh donuts, process them first
  (set! initial-fresh-donuts (+ initial-fresh-donuts (vector-ref counts 0)))
  (vector-set! counts 0 0)

  ;; Greedily process groups that can form full batches of their own remainder type
  ;; For example, if batch-size is 3 and we have 5 groups with remainder 1,
  ;; we can form one batch of (1,1,1), contributing 3 fresh donuts.
  ;; The remaining 2 groups with remainder 1 are then considered in DP.
  (for ([i (in-range 1 batch-size)])
    (set! initial-fresh-donuts (+ initial-fresh-donuts
                                  (* (quotient (vector-ref counts i) batch-size) batch-size)))
    (vector-set! counts i (modulo (vector-ref counts i) batch-size)))

  ;; Memoization table for DP states
  (define memo (make-hash))

  ;; solve function: calculates max additional fresh donuts from current state
  ;; current-counts: a vector representing counts of groups for remainders 1 to batch-size-1
  ;; current-remainder-sum: the sum of remainders of groups already in the current batch (modulo batch-size)
  (define (solve current-counts current-remainder-sum)
    ;; Create a unique, immutable key for memoization
    (define state (list (vector->list current-counts) current-remainder-sum))

    ;; If state already computed, return memoized result
    (when (hash-has-key? memo state)
      (hash-ref memo state))

    (define max-additional-groups 0)

    ;; Iterate through possible next groups (by remainder type i) to take
    (for ([i (in-range 1 batch-size)])
      (when (> (vector-ref current-counts i) 0)
        ;; Create next state by taking one group of remainder i
        (define next-counts (vector-copy current-counts))
        (vector-set! next-counts i (- (vector-ref next-counts i) 1))
        (define next-remainder-sum (modulo (+ current-remainder-sum i) batch-size))

        ;; Determine if this chosen group gets a fresh donut
        (define current-group-gets-fresh 0)
        (when (= current-remainder-sum 0)
          ;; This group is the first in a new batch, so it gets a fresh donut
          (set! current-group-gets-fresh 1))
        (when (and (> current-remainder-sum 0) (= next-remainder-sum 0))
          ;; This group completes the current batch, so it gets a fresh donut
          (set! current-group-gets-fresh 1))

        ;; Recursively find the maximum additional groups from the next state
        (set! max-additional-groups
              (max max-additional-groups
                   (+ current-group-gets-fresh (solve next-counts next-remainder-sum))))))

    ;; Memoize the result before returning
    (hash-set! memo state max-additional-groups)
    max-additional-groups)

  ;; The total maximum groups is the sum of initial greedy groups and the DP result
  (+ initial-fresh-donuts (solve counts 0)))