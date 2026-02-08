#lang racket
(require racket/set)

(define (find-subarray-bitwise-or-closest-to-k arr k)
  (define n (vector-length arr))

  (define current-min-diff (abs (- (vector-ref arr 0) k)))

  (define prev-ors (set (vector-ref arr 0)))

  (for ([j (in-range 1 n)])
    (define new-prev-ors (set))

    (set! new-prev-ors (set-add new-prev-ors (vector-ref arr j)))
    (set! current-min-diff (min current-min-diff (abs (- (vector-ref arr j) k))))

    (set-for-each 
      (lambda (prev-or-val)
        (define current-or-val (bitwise-ior prev-or-val (vector-ref arr j)))
        (set! new-prev-ors (set-add new-prev-ors current-or-val))
        (set! current-min-diff (min current-min-diff (abs (- current-or-val k)))))
      prev-ors)

    (set! prev-ors new-prev-ors))

  current-min-diff)