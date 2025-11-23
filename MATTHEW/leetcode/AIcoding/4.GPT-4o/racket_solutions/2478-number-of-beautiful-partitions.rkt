(define (beautifulPartitions s k minLength)
  (define n (string-length s))
  (define mod 1000000007)
  (define dp (make-vector (+ 1 n) 0))
  (vector-set! dp 0 1)
  (define last '())

  (for ([i (in-range n)])
    (when (and (not (null? last)) (>= (car last) minLength))
      (for ([j (in-range (length last))])
        (vector-set! dp (+ 1 (vector-ref dp (car (list-ref last j)))) 
                     (mod (+ (vector-ref dp (+ 1 (vector-ref last j))) (vector-ref dp (car (list-ref last j)))) mod))))
    (if (and (>= (char->integer (string-ref s i)) (char->integer #\2))
             (<= (char->integer (string-ref s i)) (char->integer #\9)))
      (set! last (cons (list (+ 1 i) 1) last))
      (set! last (cons (list (+ 1 i) 0) last)))
    )

  (vector-ref dp n))

(define (numberOfBeautifulPartitions s k minLength)
  (if (< (string-length s) (* k minLength))
    0
    (beautifulPartitions s k minLength)))