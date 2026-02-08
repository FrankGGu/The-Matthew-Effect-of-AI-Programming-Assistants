(define (rob nums)
  (define (rob-helper nums i memo)
    (cond
      [(>= i (length nums)) 0]
      [(hash-has-key? memo i) (hash-ref memo i)]
      [else
       (let* ([rob-current (+ (list-ref nums i) (rob-helper nums (+ i 2) memo))]
              [skip-current (rob-helper nums (+ i 1) memo)]
              [result (max rob-current skip-current)])
         (hash-set! memo i result)
         result)]))
  (rob-helper nums 0 (make-hash)))