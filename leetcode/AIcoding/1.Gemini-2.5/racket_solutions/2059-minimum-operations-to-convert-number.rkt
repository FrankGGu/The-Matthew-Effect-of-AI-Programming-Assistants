#lang racket

(require racket/queue)
(require racket/hash)

(define (minimum-operations-to-convert-number nums target)
  (let* ([q (make-queue)]
         [visited (make-hash-set)]
         [start-num 0])
    (queue-push! q (list start-num 0))
    (hash-set-add! visited start-num)
    (let bfs-loop ()
      (if (queue-empty? q)
          -1
          (let* ([current-state (queue-pop! q)]
                 [current-num (first current-state)]
                 [current-ops (second current-state)])
            (let ([found-target #f])
              (for-each (lambda (n)
                          (let* ([next-ops (+ current-ops 1)]
                                 [possible-next-nums (list (+ current-num n)
                                                           (- current-num n)
                                                           (bitwise-xor current-num n))])
                            (for-each (lambda (next-num)
                                        (cond
                                          [(= next-num target)
                                           (set! found-target next-ops)]
                                          [(and (>= next-num 0)
                                                (<= next-num 1000)
                                                (not (hash-set-contains? visited next-num)))
                                           (hash-set-add! visited next-num)
                                           (queue-push! q (list next-num next-ops))]))
                                      possible-next-nums)))
                        nums)
              (if found-target
                  found-target
                  (bfs-loop))))))))