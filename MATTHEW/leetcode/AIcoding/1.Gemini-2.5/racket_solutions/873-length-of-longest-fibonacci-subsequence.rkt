#lang racket

(define (len-longest-fib-subseq arr)
  (define n (vector-length arr))

  (define val-to-idx (make-hash))
  (for ([p (in-range n)])
    (hash-set! val-to-idx (vector-ref arr p) p))

  (define dp (make-hash)) ; Stores ((j . i) . length)
  (define max-len 0)

  (for ([i (in-range 1 n)])
    (for ([j (in-range i)]) ; j < i
      (define val-i (vector-ref arr i))
      (define val-j (vector-ref arr j))
      (define diff (- val-i val-j))

      (when (and (< diff val-j) ; Ensure arr[k] < arr[j]
                 (hash-has-key? val-to-idx diff))
        (define k (hash-ref val-to-idx diff))
        ; The length of the subsequence ending with arr[k], arr[j]
        ; If (k,j) is not in dp, it means arr[k], arr[j] is a base pair of length 2.
        (define current-len (+ (hash-ref dp (cons k j) 2) 1))
        (hash-set! dp (cons j i) current-len)
        (set! max-len (max max-len current-len)))))

  max-len)