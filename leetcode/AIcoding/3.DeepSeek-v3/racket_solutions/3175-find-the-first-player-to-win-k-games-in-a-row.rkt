(define (findWinningPlayer skills k)
  (let loop ([queue (range (length skills))]
             [current-streak 0]
             [current-winner -1])
    (cond
      [(>= current-streak k) current-winner]
      [(null? queue) (car (reverse (range (length skills))))]
      [else
       (let* ([player1 (car queue)]
              [player2 (cadr queue)]
              [winner (if (> (list-ref skills player1) (list-ref skills player2)) player1 player2)]
              [new-streak (if (= winner current-winner) (add1 current-streak) 1)]
              [new-queue (if (= winner player1)
                            (append (cdr queue) (list player2))
                            (append (cddr queue) (list player1)))]))
         (loop new-queue new-streak winner))])))