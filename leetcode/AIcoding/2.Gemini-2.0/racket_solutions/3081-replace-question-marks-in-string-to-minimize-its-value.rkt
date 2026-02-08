(define (modify-string s)
  (define n (string-length s))
  (define result (string-copy s))

  (for ([i (in-range n)])
    (when (char=? (string-ref result i) #\?)
      (for ([c (list #\a #\b #\c)])
        (define prev (if (= i 0) #\  (string-ref result (- i 1))))
        (define next (if (= i (- n 1)) #\  (string-ref result (+ i 1))))
        (when (and (not (char=? c prev)) (not (char=? c next)))
          (string-set! result i c)
          (break)))))

  result)