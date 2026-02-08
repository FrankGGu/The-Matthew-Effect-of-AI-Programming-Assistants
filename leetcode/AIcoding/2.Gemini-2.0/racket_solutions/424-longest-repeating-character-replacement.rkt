(define (characterReplacement s k)
  (define (max-freq freq)
    (apply max (hash-values freq)))

  (define (solve s k)
    (let* ([n (string-length s)]
           [left 0]
           [right 0]
           [max-length 0]
           [freq (make-hash)])

      (while (< right n)
        (let ([char (string-ref s right)])
          (hash-update! freq char (λ (v) (if v (+ v 1) 1)) 1)

          (while (> (- (+ right 1) left (max-freq freq)) k)
            (let ([left-char (string-ref s left)])
              (hash-update! freq left-char (λ (v) (- v 1)) 0)
              (set! left (+ left 1))))

          (set! max-length (max max-length (+ right 1) left))
          (set! right (+ right 1))))
      max-length))

  (solve s k))