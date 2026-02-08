(define (min-mutation start end bank)
  (define bank-set (set bank))
  (define q (queue))
  (define visited (set))
  (queue-enqueue! q (cons start 0))
  (set-add! visited start)

  (define (mutations str)
    (define res '())
    (for* ([i (range (string-length str))]
           [c '(#\A #\C #\G #\T)]
           #:when (not (equal? c (string-ref str i))))
      (define new-str (string-copy str))
      (string-set! new-str i c)
      (set! res (cons new-str res)))
    res)

  (let loop ()
    (if (queue-empty? q)
        -1
        (let* ([curr (queue-dequeue! q)]
               [gene (car curr)]
               [level (cdr curr)])
          (if (equal? gene end)
              level
              (begin
                (for ([mutation (mutations gene)])
                  (if (and (set-member? bank-set mutation)
                           (not (set-member? visited mutation)))
                      (begin
                        (queue-enqueue! q (cons mutation level+1))
                        (set-add! visited mutation))))
                (loop)))))))