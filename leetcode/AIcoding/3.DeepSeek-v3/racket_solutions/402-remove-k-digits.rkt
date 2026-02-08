(define/contract (remove-k-digits num k)
  (-> string? exact-integer? string?)
  (let loop ([digits (string->list num)]
             [k k]
             [stack '()])
    (cond
      [(= k 0) (let ([result (append (reverse stack) digits)])
                 (if (null? result)
                     "0"
                     (list->string (drop-while (lambda (c) (char=? c #\0)) result)))]
      [(null? digits) (if (zero? k)
                          (if (null? stack)
                              "0"
                              (list->string (reverse stack)))
                          (list->string (reverse (drop stack k))))]
      [else (let ([new-stack (let inner ([s stack] [d (car digits)] [rem k])
                               (cond
                                 [(or (null? s) (<= rem 0)) (cons d s)]
                                 [(char>? (car s) d)
                                  (inner (cdr s) d (sub1 rem))]
                                 [else (cons d s)]))])
              (loop (cdr digits)
                    (- k (- (length stack) (length new-stack)))
                    new-stack))])))

(define (drop-while pred lst)
  (cond
    [(null? lst) '()]
    [(pred (car lst)) (drop-while pred (cdr lst))]
    [else lst]))