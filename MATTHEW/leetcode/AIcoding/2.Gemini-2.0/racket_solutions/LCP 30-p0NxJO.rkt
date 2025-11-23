(define (magicTower game)
  (define (solve game health)
    (if (empty? game)
        0
        (let* ([negatives (filter (lambda (x) (< x 0)) game)]
               [positives (filter (lambda (x) (>= x 0)) game)]
               [negative-sum (apply + negatives (list 0))]
               [safe-game (append positives negatives)])
          (if (and (<= health (+ negative-sum health)) (null? positives))
              -1
              (let loop ([game safe-game] [health health] [steps 0])
                (cond
                  [(empty? game) steps]
                  [(< health 1) -1]
                  [else
                   (let* ([next-health (+ health (car game))])
                     (if (< (car game) 0)
                         (if (< next-health 1)
                             (let* ([min-negative (argmin (lambda (x) x) game)]
                                    [new-game (remove (list-ref game min-negative) game)]
                                    [new-steps (loop new-game health steps)])
                               (if (= new-steps -1)
                                   -1
                                   (loop (append (list (list-ref game min-negative)) new-game) health (+ steps 1))))
                             (loop (cdr game) next-health (+ steps 1)))
                         (loop (cdr game) next-health (+ steps 1)))))]))))))

  (solve game 1))

(define (argmin f lst)
  (if (null? lst)
      #f
      (let loop ([lst (cdr lst)] [min-val (f (car lst))] [min-idx 0] [idx 1])
        (if (null? lst)
            min-idx
            (let ([curr-val (f (car lst))])
              (if (< curr-val min-val)
                  (loop (cdr lst) curr-val idx (+ idx 1))
                  (loop (cdr lst) min-val min-idx (+ idx 1))))))))