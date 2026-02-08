(define (max-jumps arr d)
  (define n (vector-length arr))
  (define memo (make-vector n #f))

  (define (dp i)
    (cond
      [(vector-ref memo i) (vector-ref memo i)]
      [else
       (let* ([max-jump 1]
              [left-max (for/fold ([max-val 0])
                                  ([j (in-range (max 0 (- i d)) i)])
                           (cond [(>= (vector-ref arr j) (vector-ref arr i)) max-val]
                                 [(> (vector-ref arr j) max-val) (max (dp j) max-val)]
                                 [else max-val]))]
              [right-max (for/fold ([max-val 0])
                                   ([j (in-range (+ i 1) (min n (+ i d 1)))])
                            (cond [(>= (vector-ref arr j) (vector-ref arr i)) max-val]
                                  [(> (vector-ref arr j) max-val) (max (dp j) max-val)]
                                  [else max-val]))])
         (vector-set! memo i (+ 1 (max left-max right-max)))
         (vector-ref memo i))]))

  (for/fold ([ans 0]) ([i (in-range n)])
    (max ans (dp i))))