(define (is-perfect-square? n)
  (if (< n 0) #f
      (let* ([s (round (sqrt n))])
        (= (* s s) n))))

(define (num-squareful-arrays A)
  (let* ([n (length A)]
         [counts (make-hash)]
         [result 0])

    (for-each (lambda (x)
                (hash-set! counts x (+ (hash-ref counts x 0) 1)))
              A)

    (define unique-nums (hash-keys counts))

    (define (backtrack current-len last-val)
      (when (= current-len n)
        (set! result (+ result 1))
        (void))

      (for-each (lambda (num)
                  (let ([count (hash-ref counts num 0)])
                    (when (> count 0)
                      (when (is-perfect-square? (+ last-val num))
                        (hash-set! counts num (- count 1))
                        (backtrack (+ current-len 1) num)
                        (hash-set! counts num count)))))
                unique-nums))

    (for-each (lambda (num)
                (let ([count (hash-ref counts num 0)])
                  (when (> count 0)
                    (hash-set! counts num (- count 1))
                    (backtrack 1 num)
                    (hash-set! counts num count))))
              unique-nums)

    result))