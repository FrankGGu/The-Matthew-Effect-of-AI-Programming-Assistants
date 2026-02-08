(define (find-length arr k)
  (define (helper start end count freq)
    (cond [(> end (sub1 (length arr))) count]
          [else
           (let* ([num (list-ref arr end)]
                  [new-freq (hash-update freq num add1 0)])
             (if (<= (+ 1 (- end start)) (+ k (hash-ref new-freq num)))
                 (helper start (+ 1 end) (+ 1 count) new-freq)
                 (let* ([first-num (list-ref arr start)]
                        [new-start (+ 1 start)]
                        [new-count (- count 1)]
                        [new-freq2 (hash-update freq first-num sub1 0)])
                   (helper new-start end new-count new-freq2))))]))

  (let loop ([i 0] [max-len 0])
    (cond [(>= i (length arr)) max-len]
          [else (loop (+ 1 i) (max max-len (helper i i 1 (hash (list (cons (list-ref arr i) 1))))))]))
  )