(define (most-frequent-sequence s)
  (let ([n (length s)])
    (if (< n 3)
        '()
        (let ([counts (make-hash)])
          (let loop ([l1 s] [l2 (cdr s)] [l3 (cddr s)])
            (when (and l1 l2 l3)
              (let* ([seq (list (car l1) (car l2) (car l3))])
                (hash-set! counts seq (+ (hash-ref counts seq 0) 1)))
              (loop (cdr l1) (cdr l2) (cdr l3))))

          (let ([max-count -1])
            (let ([result '()])
              (hash-for-each
               counts
               (lambda (seq count)
                 (cond
                   ((> count max-count)
                    (set! max-count count)
                    (set! result seq))
                   ((= count max-count)
                    (let ([s1 (car seq)] [s2 (cadr seq)] [s3 (caddr seq)])
                      (let ([r1 (car result)] [r2 (cadr result)] [r3 (caddr result)])
                        (cond
                          [(string<? s1 r1) (set! result seq)]
                          [(string>? s1 r1) (void)]
                          [else
                           (cond
                             [(string<? s2 r2) (set! result seq)]
                             [(string>? s2 r2) (void)]
                             [else
                              (when (string<? s3 r3)
                                (set! result seq))])])))
                   [else (void)])))
              result))))))