(define/contract (longest-subarray nums limit)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([left 0] [right 0] [max-len 0]
             [min-deque '()] [max-deque '()])
    (if (>= right (length nums))
        max-len
        (let* ([current (list-ref nums right)]
               [new-min-deque (let f ([dq min-deque])
                                (if (or (null? dq) (< current (car (last-pair dq))))
                                    (f (drop-right dq 1))
                                    dq))]
               [new-min-deque (append new-min-deque (list current))]
               [new-max-deque (let f ([dq max-deque])
                                (if (or (null? dq) (> current (car (last-pair dq))))
                                    (f (drop-right dq 1))
                                    dq))]
               [new-max-deque (append new-max-deque (list current))])
          (if (<= (- (car new-max-deque) (car new-min-deque)) limit)
              (loop left (+ right 1) (max max-len (+ (- right left) 1))
              (let* ([left-val (list-ref nums left)]
                     [new-min-deque (if (= left-val (car new-min-deque))
                                       (cdr new-min-deque)
                                       new-min-deque)]
                     [new-max-deque (if (= left-val (car new-max-deque))
                                       (cdr new-max-deque)
                                       new-max-deque)])
                (loop (+ left 1) right max-len new-min-deque new-max-deque))))))))