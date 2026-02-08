#lang racket

(define (len-longest-fib-subseq arr)
  (define n (vector-length arr))
  (if (< n 3)
      0
      (begin
        (define val-to-idx (make-hash))
        (for ([i (in-range n)])
          (hash-set! val-to-idx (vector-ref arr i) i))

        (define dp (build-vector n (lambda (_) (build-vector n (lambda (__ ) 0)))))

        (define max-len 0)

        (for ([j (in-range n)])
          (for ([i (in-range j)])
            (define current-j (vector-ref arr j))
            (define current-i (vector-ref arr i))
            (define prev-val (- current-j current-i))

            (when (and (< prev-val current-i)
                       (hash-has-key? val-to-idx prev-val))
              (define k (hash-ref val-to-idx prev-val))

              (define len-k-i (vector-ref (vector-ref dp k) i))
              (define current-fib-len (if (= len-k-i 0) 3 (+ len-k-i 1)))

              (vector-set! (vector-ref dp i) j current-fib-len)
              (set! max-len (max max-len current-fib-len))))
        max-len)))