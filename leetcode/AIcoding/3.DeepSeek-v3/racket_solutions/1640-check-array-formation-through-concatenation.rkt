(define/contract (can-form-array arr pieces)
  (-> (listof exact-integer?) (listof (listof exact-integer?)) boolean?)
  (let ([pos (make-hash)])
    (for ([piece pieces] [i (in-naturals)])
      (hash-set! pos (car piece) i))
    (let loop ([i 0])
      (cond
        [(>= i (length arr)) #t]
        [(not (hash-has-key? pos (list-ref arr i))) #f]
        [else
         (let* ([index (hash-ref pos (list-ref arr i))]
                [piece (list-ref pieces index)])
           (if (equal? (take (drop arr i) (length piece)) piece)
               (loop (+ i (length piece)))
               #f))]))))