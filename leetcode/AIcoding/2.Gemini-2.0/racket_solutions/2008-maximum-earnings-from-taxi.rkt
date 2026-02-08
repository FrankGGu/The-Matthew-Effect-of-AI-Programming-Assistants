(define (max-taxi-earnings n rides)
  (define adj (make-vector (add1 n) '()))
  (for ([ride rides])
    (vector-set! adj (first ride) (cons ride (vector-ref adj (first ride))))
    )
  (define memo (make-hash))
  (define (dp i)
    (cond
      [(hash-has-key? memo i) (hash-ref memo i)]
      [else
       (let* ([next-rides (vector-ref adj i)]
              [max-earn (dp (add1 i))]
              [with-rides
               (foldl (lambda (ride acc)
                        (max acc (+ (- (second ride) (first ride)) (third ride) (dp (second ride)))))
                      0 next-rides)])
         (hash-set! memo i (max max-earn with-rides))
         (hash-ref memo i))]))
  (dp 1))