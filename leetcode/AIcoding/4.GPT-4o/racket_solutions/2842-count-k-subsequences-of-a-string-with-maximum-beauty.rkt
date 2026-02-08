(define (countKSubsequences s k)
  (define (char-count str)
    (for/fold ([counts (make-vector 26 0)]) ([c (in-string str)])
      (vector-set! counts (- (char->integer c) (char->integer #\a)) (+ 1 (vector-ref counts (- (char->integer c) (char->integer #\a)))))))

  (define counts (char-count s))
  (define filtered-counts (filter (lambda (x) (> x 0)) (vector->list counts)))
  (define max-beauty (apply max filtered-counts))

  (define beauty-count (length (filter (lambda (x) (= x max-beauty)) filtered-counts)))

  (if (>= beauty-count k)
      (expt beauty-count k)
      0))

(define (countKSubsequencesWrapper s k)
  (countKSubsequences s k))