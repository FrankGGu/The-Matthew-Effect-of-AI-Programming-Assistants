(define (count-almost-equal-pairs nums)
  (let* ([freq (make-hash)]
         [count 0])
    (for-each (lambda (x)
                (hash-update! freq x (lambda (v) (add1 v)) 0))
              nums)

    (for-each (lambda (num)
                (let ([current-freq (hash-ref freq num 0)])
                  (set! count (+ count (/ (* current-freq (- current-freq 1)) 2)))
                  (let ([next-freq (hash-ref freq (+ num 1) 0)])
                    (set! count (+ count (* current-freq next-freq))))))
              (hash-keys freq))
    count))