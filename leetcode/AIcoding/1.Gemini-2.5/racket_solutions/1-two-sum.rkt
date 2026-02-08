(define (two-sum nums target)
  (define seen-numbers (make-hash))
  (let loop ([idx 0] [remaining-nums nums])
    (define current-num (car remaining-nums))
    (define complement (- target current-num))
    (cond
      [(hash-has-key? seen-numbers complement)
       (list (hash-ref seen-numbers complement) idx)]
      [else
       (hash-set! seen-numbers current-num idx)
       (loop (+ idx 1) (cdr remaining-nums))])))