(define/contract (next-beautiful-number n)
  (-> exact-integer? exact-integer?)
  (define (is-balanced? num)
    (let* ([s (number->string num)]
           [counts (make-hash)])
      (for ([c s])
        (hash-update! counts c add1 0))
      (for/and ([(k v) counts])
        (= (string->number (string k)) v))))

  (let loop ([i (+ n 1)])
    (if (is-balanced? i)
        i
        (loop (+ i 1)))))