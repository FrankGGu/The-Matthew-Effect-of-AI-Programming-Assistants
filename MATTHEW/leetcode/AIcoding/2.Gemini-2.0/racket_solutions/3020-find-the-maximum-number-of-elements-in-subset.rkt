(define (maximum-length subset)
  (let* ([freq (make-hash)]
         [n (length subset)])
    (for ([x subset])
      (hash-update! freq x (lambda (v) (+ v 1)) 1))
    (let loop ([nums (sort (hash-keys freq) <)]
               [count 0])
      (cond
        [(null? nums) count]
        [(= (hash-ref freq (car nums)) 0) (loop (cdr nums) count)]
        [(= (car nums) 1)
         (let ([ones (hash-ref freq 1)])
           (loop (cdr nums) (if (odd? ones) ones (- ones 1))))]
        [else
         (let ([val (car nums)])
           (cond
             [(not (hash-has-key? freq (* val val)))
              (loop (cdr nums) count)]
             [else
              (hash-update! freq val (lambda (v) (- v 1)) 0)
              (hash-update! freq (* val val) (lambda (v) (- v 1)) 0)
              (loop (cdr nums) (+ count 2))]))])))))