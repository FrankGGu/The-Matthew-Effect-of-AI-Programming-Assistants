(define (find-original-array changed)
  (let* ([n (length changed)]
         [half-n (/ n 2)]
         [counts (make-hash)]
         [original '()])
    (if (odd? n)
        '()
        (begin
          (for ([x (in-list changed)])
            (hash-update! counts x (λ (v) (+ v 1)) 0))

          (for ([x (in-list (sort changed <))])
            (cond
              [(and (hash-has-key? counts x) (> (hash-ref counts x) 0))
               (let ([doubled-x (* x 2)])
                 (cond
                   [(and (hash-has-key? counts doubled-x) (> (hash-ref counts doubled-x) 0))
                    (set! original (append original (list x)))
                    (hash-update! counts x sub1)
                    (hash-update! counts doubled-x sub1)]
                   [else
                    (set! original '())
                    (break)]) )]
              [else #f]))

          (if (= (length original) half-n)
              original
              '())))))