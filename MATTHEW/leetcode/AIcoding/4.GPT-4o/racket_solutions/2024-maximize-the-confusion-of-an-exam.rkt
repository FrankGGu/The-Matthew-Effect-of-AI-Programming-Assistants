(define (maximizeConfusion answerKey k)
  (define (max-length char)
    (let loop ((i 0) (j 0) (count 0) (max 0))
      (cond
        ((= j (string-length answerKey)) max)
        ((char= (string-ref answerKey j) char)
         (loop i (+ j 1) count max))
        (else
         (if (< count k)
             (loop i (+ j 1) (+ count 1) max)
             (loop (+ i 1) (+ i 1) (- count 1) max)))
        (set! max (max max (- j i)))))))

  (max (max-length #\T) (max-length #\F)))