(define (rob nums)
  (define (rob-helper nums i memo)
    (cond
      [(hash-has-key? memo i) (hash-ref memo i)]
      [(< i 0) 0]
      [else
       (let ([result (max (+ (list-ref nums i) (rob-helper nums (- i 2) memo))
                          (rob-helper nums (- i 1) memo))])
         (hash-set! memo i result)
         result)]))

  (rob-helper nums (- (length nums) 1) (make-hash)))