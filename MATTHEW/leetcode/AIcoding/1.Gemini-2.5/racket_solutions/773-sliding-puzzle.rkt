(require racket/set)

(define (sliding-puzzle board)
  (define initial-flat-board (apply append board))
  (define target-flat-board '(1 2 3 4 5 0))

  (define (find-zero-pos current-board)
    (for/first ([val (in-list current-board)]
                [idx (in-naturals)]
                #:when (= val 0))
      idx))

  (define (swap-elements lst i j)
    (let* ([val-i (list-ref lst i)]
           [val-j (list-ref lst j)]
           [temp-lst (list-set lst i val-j)])
      (list-set temp-lst j val-i)))

  (define adj-map
    (list
     '(1 3)
     '(0 2 4)
     '(1 5)
     '(0 4)
     '(1 3 5)
     '(2 4)))

  (let bfs-loop ([queue (list (list initial-flat-board 0))]
                 [visited (set initial-flat-board)])
    (cond
      [(empty? queue) -1]
      [else
       (let* ([current-item (first queue)]
              [current-board (first current-item)]
              [current-moves (second current-item)]
              [rest-queue (rest queue)])

         (when (equal? current-board target-flat-board)
           (current-moves))

         (let* ([zero-pos (find-zero-pos current-board)]
                [possible-swaps (list-ref adj-map zero-pos)])

           (let-values ([(next-queue next-visited)
                         (for/fold ([acc-q rest-queue] [acc-v visited])
                                   ([swap-pos (in-list possible-swaps)])
                           (let ([next-board (swap-elements current-board zero-pos swap-pos)])
                             (if (set-member? acc-v next-board)
                                 (values acc-q acc-v)
                                 (values (append acc-q (list (list next-board (+ current-moves 1))))
                                         (set-add acc-v next-board))))])
             (bfs-loop next-queue next-visited))))])))