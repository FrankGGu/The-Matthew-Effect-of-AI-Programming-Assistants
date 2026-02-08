#lang racket

(define/contract (num-factored-binary-trees arr)
  (-> (listof exact-integer?) exact-integer?)
  (define mod (expt 10 9 7))
  (define sorted-arr (sort arr <))
  (define n (length sorted-arr))
  (define dp (make-hash))

  (for ([i (in-range n)])
    (hash-set! dp (list-ref sorted-arr i) 1))

  (for ([i (in-range n)])
    (define current (list-ref sorted-arr i))
    (for ([j (in-range i)])
      (define left (list-ref sorted-arr j))
      (when (zero? (modulo current left))
        (define right (quotient current left))
        (when (hash-has-key? dp right)
          (define val (+ (hash-ref dp current)
                         (* (hash-ref dp left) (hash-ref dp right))))
          (hash-set! dp current (modulo val mod)))))

  (modulo (apply + (hash-values dp)) mod))