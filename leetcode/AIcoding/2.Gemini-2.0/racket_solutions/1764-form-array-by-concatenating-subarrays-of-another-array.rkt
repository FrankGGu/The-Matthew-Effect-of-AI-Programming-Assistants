(define (canFormArray arr pieces)
  (let* ((piece-map (make-hash))
         (arr-len (length arr)))
    (for ([piece pieces])
      (hash-set! piece-map (car piece) piece))
    (let loop ([i 0])
      (cond
        [(>= i arr-len) #t]
        [(not (hash-has-key? piece-map (list-ref arr i))) #f]
        [else
         (let* ([piece (hash-ref piece-map (list-ref arr i))]
                [piece-len (length piece)])
           (if (and (>= (+ i piece-len) arr-len) (equal? piece (take arr piece-len)))
               #t
               (if (equal? piece (take arr (+ i piece-len)))
                   (loop (+ i piece-len))
                   #f)))]))))