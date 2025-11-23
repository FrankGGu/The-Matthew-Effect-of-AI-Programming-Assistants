(define (num-ways words target)
  (define m (string-length target))
  (define n (length words))
  (define word-len (string-length (car words)))
  (define char-counts
    (make-vector word-len (λ (i) (make-hash))))

  (for* ([word words] [i word-len])
    (define char (string-ref word i))
    (hash-update! (vector-ref char-counts i) char (λ (v) (+ v 1)) 0))

  (define dp (make-vector (+ m 1) 0))
  (vector-set! dp 0 1)

  (for ([i 0 word-len])
    (for ([j m] #:when (> j 0))
      (define char (string-ref target (- j 1)))
      (define count (hash-ref (vector-ref char-counts i) char 0))
      (vector-set! dp j (modulo (+ (vector-ref dp j) (* (vector-ref dp (- j 1)) count)) 1000000007))))

  (vector-ref dp m))