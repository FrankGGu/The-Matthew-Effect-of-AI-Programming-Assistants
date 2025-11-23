#lang racket

(define (find-shortest-sub-array nums)
  (define frequencies (make-hash))
  (define first-occurrences (make-hash))
  (define last-occurrences (make-hash))

  (for ([num (in-indexed nums)]
        [i (in-naturals)])
    (hash-update! frequencies num add1 0)
    (when (not (hash-has-key? first-occurrences num))
      (hash-set! first-occurrences num i))
    (hash-set! last-occurrences num i))

  (define max-freq 0)
  (for ([(k v) frequencies])
    (set! max-freq (max max-freq v)))

  (define min-len (add1 (length nums))) ; Initialize with a value larger than any possible length

  (for ([(num freq) frequencies])
    (when (= freq max-freq)
      (define first-idx (hash-ref first-occurrences num))
      (define last-idx (hash-ref last-occurrences num))
      (set! min-len (min min-len (add1 (- last-idx first-idx))))))

  min-len)