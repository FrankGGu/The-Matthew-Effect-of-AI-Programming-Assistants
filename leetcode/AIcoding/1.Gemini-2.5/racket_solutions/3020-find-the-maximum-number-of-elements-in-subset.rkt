#lang racket

(define (find-maximum-number-of-elements-in-subset nums)
  (define num-set (make-hash))
  (for-each (lambda (n) (hash-set! num-set n #t)) nums)

  (define max-len 0)

  ;; If 1 is in the set, it can form a subset of size 1.
  (when (hash-has-key? num-set 1)
    (set! max-len 1))

  ;; Memoization table for computed chain lengths of bases
  (define memo (make-hash))

  ;; Iterate through each number in the input list
  (for-each (lambda (num)
              ;; Skip 1 as its chain is trivially 1, and it's handled separately
              ;; or as part of other chains.
              (when (not (= num 1))
                ;; Find the "base" of the current number.
                ;; The base is the smallest number 'b' in the chain such that
                ;; b, b^2, b^4, ... are in the set, and sqrt(b) is not an integer
                ;; or sqrt(b) is not in the set.
                (let loop-for-base ((curr num))
                  (define-values (s r) (exact-integer-sqrt curr))
                  (if (and (= r 0) (hash-has-key? num-set s))
                      ;; If curr is a perfect square and its sqrt is in the set,
                      ;; go down to the sqrt to find the true base.
                      (loop-for-base s)
                      ;; curr is now the base for this chain.
                      (begin
                        ;; If this base has not been processed yet
                        (when (not (hash-has-key? memo curr))
                          ;; Calculate the length of the chain starting from this base
                          (let loop-chain ((temp curr) (current-chain-len 0))
                            (if (hash-has-key? num-set temp)
                                ;; If temp is in the set, extend the chain by squaring it
                                (loop-chain (* temp temp) (+ current-chain-len 1))
                                ;; If temp is not in the set, the chain ends
                                (begin
                                  ;; Store the computed length for this base
                                  (hash-set! memo curr current-chain-len)
                                  ;; Update the overall maximum length
                                  (set! max-len (max max-len current-chain-len))))))))))
            nums)
  max-len)