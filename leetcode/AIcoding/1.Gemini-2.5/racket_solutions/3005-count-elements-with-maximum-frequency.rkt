(define (max-frequency-elements nums)
  (let* ([freq-map (make-hash)]
         [_ (for-each (lambda (num)
                        (hash-set! freq-map num (+ (hash-ref freq-map num 0) 1)))
                      nums)]
         [frequencies (hash-values freq-map)]
         [max-freq (if (empty? frequencies)
                       0
                       (apply max frequencies))]
         [count-max-freq-elements (if (= max-freq 0)
                                      0
                                      (for/sum ([f frequencies])
                                        (if (= f max-freq) 1 0)))])
    (* max-freq count-max-freq-elements)))