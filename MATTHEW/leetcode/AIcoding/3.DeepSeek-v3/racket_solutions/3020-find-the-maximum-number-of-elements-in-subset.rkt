(define (maximum-length nums)
  (let loop ([nums nums] [seen (hash)] [max-len 0])
    (cond
      [(empty? nums) max-len]
      [else
       (let* ([num (first nums)]
              [new-seen (hash-copy seen)]
              [keys (hash-keys new-seen)])
         (hash-set! new-seen num #t)
         (for ([k keys])
           (let ([new-num (* num k)])
             (when (and (not (hash-has-key? new-seen new-num))
                        (>= new-num 1))
               (hash-set! new-seen new-num #t))))
         (loop (rest nums) new-seen (max max-len (hash-count new-seen))))])))