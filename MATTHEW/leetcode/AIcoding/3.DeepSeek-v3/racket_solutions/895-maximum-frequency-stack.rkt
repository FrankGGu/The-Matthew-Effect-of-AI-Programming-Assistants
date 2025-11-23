(define freq-hash (make-hash))
(define group-hash (make-hash))
(define max-freq 0)

(define (push x)
  (let* ([freq (add1 (hash-ref freq-hash x 0))])
    (hash-set! freq-hash x freq)
    (when (> freq max-freq)
      (set! max-freq freq))
    (let ([stack (hash-ref group-hash freq null)])
      (hash-set! group-hash freq (cons x stack)))))

(define (pop)
  (let* ([stack (hash-ref group-hash max-freq)]
         [x (car stack)]
         [new-stack (cdr stack)])
    (hash-set! group-hash max-freq new-stack)
    (hash-set! freq-hash x (sub1 (hash-ref freq-hash x)))
    (when (null? new-stack)
      (set! max-freq (sub1 max-freq)))
    x))

(define (FreqStack)
  (make-object
   (class object%
     (super-new)
     (define/public (push x) (push x))
     (define/public (pop) (pop)))))