(define (distinct-subseq-ii s)
  (define mod 1000000007)
  (define n (string-length s))
  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 0 1)
  (define last (make-vector 256 -1))

  (for ([i (in-range n)])
    (let* ([char (char->integer (string-ref s i))]
           [prev (vector-ref last char)]
           [count (vector-ref dp i)])
      (vector-set! dp (+ i 1) (mod (+ count (mod (- (vector-ref dp i) prev) mod)) mod))
      (vector-set! last char i)))

  (mod (- (vector-ref dp n) 1) mod))

(define (numDistinct s)
  (distinct-subseq-ii s))