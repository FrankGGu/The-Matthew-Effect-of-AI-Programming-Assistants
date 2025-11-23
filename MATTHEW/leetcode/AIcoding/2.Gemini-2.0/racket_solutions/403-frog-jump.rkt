(define (can-cross stones)
  (define n (length stones))
  (define stone-set (set stones))
  (define memo (make-hash))

  (define (helper k last-jump)
    (cond
      [(equal? k (- n 1)) #t]
      [(hash-has-key? memo (cons k last-jump)) (hash-ref memo (cons k last-jump))]
      [else
       (let* ([res (or (and (set-member? stone-set (+ (list-ref stones k) last-jump -1))
                           (let ([next-stone-index (findf-index (lambda (i) (equal? (+ (list-ref stones k) last-jump -1) (list-ref stones i))) stones)])
                             (and next-stone-index (helper next-stone-index last-jump -1))))
                        (and (set-member? stone-set (+ (list-ref stones k) last-jump))
                           (let ([next-stone-index (findf-index (lambda (i) (equal? (+ (list-ref stones k) last-jump) (list-ref stones i))) stones)])
                             (and next-stone-index (helper next-stone-index last-jump))))
                        (and (set-member? stone-set (+ (list-ref stones k) last-jump 1))
                           (let ([next-stone-index (findf-index (lambda (i) (equal? (+ (list-ref stones k) last-jump 1) (list-ref stones i))) stones)])
                             (and next-stone-index (helper next-stone-index last-jump 1))))
                        )])
         (hash-set! memo (cons k last-jump) res)
         res)]))

  (helper 0 0))