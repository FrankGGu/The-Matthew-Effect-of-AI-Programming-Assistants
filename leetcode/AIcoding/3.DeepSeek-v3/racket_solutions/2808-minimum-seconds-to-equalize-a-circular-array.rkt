(define (minimum-seconds nums)
  (let* ([n (length nums)]
         [pos (make-hash)])
    (for ([num nums] [i (in-naturals)])
      (hash-update! pos num (lambda (lst) (cons i lst)) '()))
    (let ([max-gap 0])
      (hash-for-each pos (lambda (k lst)
                           (let* ([sorted (sort lst <)]
                                  [m (length sorted)]
                                  [gap (for/fold ([max-g 0])
                                                 ([i (in-range m)])
                                         (let ([prev (if (= i 0) (last sorted) (list-ref sorted (sub1 i)))]
                                               [curr (list-ref sorted i)])
                                         (max max-g (if (= i 0)
                                                        (+ (- n prev) curr -1)
                                                        (- curr prev 1))))])
                             (set! max-gap (max max-gap gap)))))
                     )
      (ceiling (/ max-gap 2)))))