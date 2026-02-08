(define (most-frequent-number-following-key-in-an-array nums key)
  (let ([freq-map (make-hash)])
    (for ([i (range (- (length nums) 1))])
      (when (= (list-ref nums i) key)
        (let ([target (list-ref nums (+ i 1))])
          (hash-set! freq-map target (add1 (hash-ref freq-map target 0))))))

    (let-values ([(max-target max-freq)
                  (for/fold ([current-max-target -1]
                             [current-max-freq 0])
                            [(target freq) (in-hash freq-map)]
                    (cond
                      [(> freq current-max-freq)
                       (values target freq)]
                      [(= freq current-max-freq)
                       (values (min current-max-target target) freq)]
                      [else
                       (values current-max-target current-max-freq)]))])
      max-target)))