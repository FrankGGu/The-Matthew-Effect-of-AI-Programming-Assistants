(define (count-interesting-subarrays nums modulo k)
  (let* ([count 0]
         [current-prefix-sum-mod 0]
         [freq-map (make-hash)])
    (hash-set! freq-map 0 1)

    (for-each (lambda (num)
                (set! current-prefix-sum-mod
                      (modulo (+ current-prefix-sum-mod num) modulo))

                (let* ([target-prefix-sum-mod
                        (modulo (- current-prefix-sum-mod k) modulo)])
                  (set! count
                        (+ count (hash-ref freq-map target-prefix-sum-mod 0))))

                (hash-set! freq-map current-prefix-sum-mod
                           (+ (hash-ref freq-map current-prefix-sum-mod 0) 1)))
              nums)
    count))