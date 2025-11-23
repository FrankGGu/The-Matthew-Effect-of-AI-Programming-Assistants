(define/contract (minimum-time tasks)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([sorted-tasks (sort tasks (lambda (a b) (< (third a) (third b))))]
         [slots (make-hash)])
    (for ([task sorted-tasks])
      (let ([start (first task)]
            [end (second task)]
            [duration (third task)]
            [count 0])
        (for ([i (in-range start (add1 end))])
          (when (hash-has-key? slots i)
            (set! count (add1 count))))
        (let ([remaining (- duration count)])
          (when (> remaining 0)
            (for ([i (in-range end (sub1 start) -1)]
              #:break (<= remaining 0)
              (unless (hash-has-key? slots i)
                (hash-set! slots i #t)
                (set! remaining (sub1 remaining)))))))
    (hash-count slots)))