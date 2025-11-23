(define (num-jewels-in-stones jewels stones)
  (let loop ([jewels-set (set (string->list jewels))]
             [stones-list (string->list stones)]
             [count 0])
    (cond
      [(empty? stones-list) count]
      [(set-member? jewels-set (car stones-list))
       (loop jewels-set (cdr stones-list) (+ count 1))]
      [else
       (loop jewels-set (cdr stones-list) count)])))