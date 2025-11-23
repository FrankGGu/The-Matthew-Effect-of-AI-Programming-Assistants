(define (findMinimumSteps ring key)
  (define (char-index c)
    (- (char->integer c) (char->integer #\a)))

  (define n (string-length ring))
  (define m (string-length key))

  (define memo (make-hash))

  (define (dp pos k)
    (if (= k m)
        0
        (let ([memo-key (cons pos k)])
          (if (hash-has-key? memo memo-key)
              (hash-ref memo memo-key)
              (let* ([target-char (string-ref key k)]
                     [min-steps +inf.0])
                (for ([i (in-range n)])
                  (when (char=? (string-ref ring i) target-char)
                    (let* ([diff (abs (- i pos))]
                           [steps (min diff (- n diff))]
                           [total-steps (+ steps 1 (dp i (+ k 1)))]
                           [min-steps (min min-steps total-steps)])))
                (hash-set! memo memo-key min-steps)
                min-steps)))))

  (dp 0 0))