(define (reverse-string-ii s k)
  (let* ((char-vec (string->vector s))
         (len (vector-length char-vec)))

    (define (reverse-segment! start end) ; Reverses segment [start, end-1]
      (let loop ((i start) (j (- end 1)))
        (when (< i j)
          (let ((temp (vector-ref char-vec i)))
            (vector-set! char-vec i (vector-ref char-vec j))
            (vector-set! char-vec j temp))
          (loop (+ i 1) (- j 1)))))

    (let loop ((i 0))
      (when (< i len)
        (let* ((start-reverse i)
               (end-reverse (min (+ i k) len)))
          (reverse-segment! start-reverse end-reverse))
        (loop (+ i (* 2 k)))))

    (vector->string char-vec)))

(define (solution s k)
  (reverse-string-ii s k))