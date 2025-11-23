(define/contract (max-equal-freq nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [counts (hash)] [freqs (hash)] [max-len 0] [max-freq 0])
    (if (null? nums)
        max-len
        (let* ([num (car nums)]
               [new-counts (hash-update counts num add1 1)]
               [count (hash-ref new-counts num)]
               [new-freqs (hash-update freqs count add1 1)]
               [new-freqs (if (> count 1) (hash-update new-freqs (sub1 count) sub1 0) new-freqs)]
               [new-max-freq (max max-freq count)]
               [valid (or (= (hash-count new-freqs) 1)
                          (and (= (hash-count new-freqs) 2)
                               (or (and (hash-has-key? new-freqs 1) (= (hash-ref new-freqs 1) 1))
                                   (and (hash-has-key? new-freqs (add1 new-max-freq)) (= (hash-ref new-freqs (add1 new-max-freq)) 1)))))])
          (loop (cdr nums) new-counts new-freqs (if valid (add1 max-len) max-len) new-max-freq)))))