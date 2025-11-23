(define (maximum-sum nums)
  (define (sum-digits n)
    (if (= n 0)
        0
        (+ (remainder n 10) (sum-digits (quotient n 10)))))

  (define digit-sum-map (make-hash))

  (for-each (lambda (num)
              (define s (sum-digits num))
              (hash-set! digit-sum-map s (cons num (hash-ref digit-sum-map s '()))))
            nums)

  (define max-pair-sum -1)

  (hash-for-each
   digit-sum-map
   (lambda (s num-list)
     (when (>= (length num-list) 2)
       (define sorted-nums (sort num-list >))
       (define current-sum (+ (car sorted-nums) (cadr sorted-nums)))
       (when (> current-sum max-pair-sum)
         (set! max-pair-sum current-sum)))))

  max-pair-sum)