(define (max-equal-freq nums)
  (let* ([n (length nums)]
         [freq (make-hash '())]
         [count (make-hash '())]
         [max-freq 0]
         [res 0])
    (for ([i (in-range n)])
      (let ([num (list-ref nums i)])
        (when (hash-has-key? freq num)
          (let ([f (hash-ref freq num)])
            (hash-update! count f (lambda (x) (- x 1)) 0)
            (when (= (hash-ref count f) 0)
              (hash-remove! count f))))
        (hash-update! freq num (lambda (x) (+ x 1)) 1)
        (let ([f (hash-ref freq num)])
          (hash-update! count f (lambda (x) (+ x 1)) 1)
          (set! max-freq (max max-freq f))
          (cond
            [(= 1 (hash-count count))
             (cond
               [(= 1 max-freq) (set! res (+ i 1))]
               [(= 1 (hash-ref count max-freq)) (set! res (+ i 1))])]
            [(= 2 (hash-count count))
             (let ([freqs (hash-keys count)])
               (let ([f1 (car freqs)]
                     [f2 (cadr freqs)])
                 (cond
                   [(and (= 1 f1) (= 1 (hash-ref count f1))) (set! res (+ i 1))]
                   [(and (= 1 f2) (= 1 (hash-ref count f2))) (set! res (+ i 1))]
                   [(and (= (+ f1 1) f2) (= 1 (hash-ref count f2))) (set! res (+ i 1))]
                   [(and (= (+ f2 1) f1) (= 1 (hash-ref count f1))) (set! res (+ i 1))]))])]))))
    res))