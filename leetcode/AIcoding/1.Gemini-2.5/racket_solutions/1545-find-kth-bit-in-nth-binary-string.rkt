#lang racket

(define (find-kth-bit n k)
  (cond
    [(= n 1)
     #\0]
    [else
     (let* ([mid-pos (expt 2 (sub1 n))] ; The position of '1' in S_n (1-indexed)
            [len-prev (sub1 mid-pos)]) ; The length of S_{n-1}
       (cond
         [(= k mid-pos)
          #\1]
         [(< k mid-pos)
          (find-kth-bit (sub1 n) k)]
         [else ; (> k mid-pos)
          ; k is in the reversed and inverted part
          ; k-prime is the 1-indexed position in reverse(invert(S_{n-1}))
          (let* ([k-prime (- k mid-pos)]
                 ; original-k is the 1-indexed position in S_{n-1}
                 ; corresponding to k-prime in reverse(invert(S_{n-1}))
                 [original-k (+ (- len-prev k-prime) 1)]
                 [bit-in-sn-1 (find-kth-bit (sub1 n) original-k)])
            (if (char=? bit-in-sn-1 #\0)
                #\1
                #\0))]))]))