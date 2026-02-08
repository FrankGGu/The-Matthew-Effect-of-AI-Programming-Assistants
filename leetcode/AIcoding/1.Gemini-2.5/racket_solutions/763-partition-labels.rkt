(define (partition-labels s)
  (define n (string-length s))
  (define last-pos (make-vector 26 0))

  (for ([i (in-range n)])
    (define char-code (- (char->integer (string-ref s i)) (char->integer #\a)))
    (vector-set! last-pos char-code i))

  (define result '())
  (define start 0)
  (define max-reach 0)

  (for ([i (in-range n)])
    (define char-code (- (char->integer (string-ref s i)) (char->integer #\a)))
    (set! max-reach (max max-reach (vector-ref last-pos char-code)))

    (when (= i max-reach)
      (set! result (cons (- i start -1) result))
      (set! start (+ i 1))))

  (reverse result))