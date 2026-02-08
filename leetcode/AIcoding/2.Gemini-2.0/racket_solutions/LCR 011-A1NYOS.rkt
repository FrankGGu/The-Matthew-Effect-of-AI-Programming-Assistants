(define (findMaxLength nums)
  (let loop ([nums nums] [hm (make-hash #hasheqv)] [count 0] [max-len 0] [idx 0])
    (cond
      [(null? nums) max-len]
      [else
       (let* ([num (car nums)]
              [new-count (if (= num 0) (- count 1) (+ count 1))])
         (cond
           [(hash-has-key? hm new-count)
            (let ([first-idx (hash-ref hm new-count)])
              (loop (cdr nums) hm new-count (max max-len (- idx first-idx)) (+ idx 1)))]
           [else
            (hash-set! hm new-count idx)
            (loop (cdr nums) hm new-count max-len (+ idx 1))])))])))

(define (main nums)
  (let ([hm (make-hash #hasheqv)])
    (hash-set! hm 0 -1)
    (findMaxLength nums)))