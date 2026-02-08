(define (count-pairs-that-form-a-complete-day hours)
  (let ([freq-map (make-hash)]
        [total-pairs 0])
    (for-each (lambda (h)
                (let* ([rem (modulo h 24)]
                       [target-rem (if (= rem 0) 0 (- 24 rem))])
                  (set! total-pairs (+ total-pairs (hash-ref freq-map target-rem 0)))
                  (hash-set! freq-map rem (+ (hash-ref freq-map rem 0) 1))))
              hours)
    total-pairs))