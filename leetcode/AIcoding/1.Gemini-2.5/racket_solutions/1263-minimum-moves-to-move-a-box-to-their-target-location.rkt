#lang racket

(require data/queue)
(require data/set)

(define (min-pushes grid)
  (define rows (length grid))
  (define cols (length (car grid)))

  (define initial-pr -1)
  (define initial-pc -1)
  (define initial-br -1)
  (define initial-bc -1)
  (define target-r -1)
  (define target-c -1)

  (for ([r (in-range rows)])
    (for ([c (in-range cols)])
      (case (list-ref (list-ref grid r) c)
        [#\S (set! initial-pr r) (set! initial-pc c)]
        [#\B (set! initial-br r) (set! initial-bc c)]
        [#\T (set! target-r r) (set! target-c c)]
        [else #f])))

  (define (valid? r c)
    (and (>= r 0) (< r rows)
         (>= c 0) (< c cols)
         (not (char=? (list-ref (list-ref grid r) c) #\#))))

  (define player-dirs '((-1 0) (1 0) (0 -1) (0 1)))

  (define (can-player-reach? start-pr start-pc target-pr target-pc box-r box-c)
    (when (and (= start-pr target-pr) (= start-pc target-pc))
      (values #t))

    (define player-q (make-queue))
    (define player-visited (set))

    (queue-add! player-q (list start-pr start-pc))
    (set! player-visited (set-add player-visited (list start-pr start-pc)))

    (let loop ()
      (cond
        ((queue-empty? player-q) #f)
        (else
         (define current-pos (queue-remove! player-q))
         (define curr-pr (car current-pos))
         (define curr-pc (cadr current-pos))

         (for ([dir player-dirs])
           (define dr (car dir))
           (define dc (cadr dir))
           (define next-pr (+ curr-pr dr))
           (define next-pc (+ curr-pc dc))
           (define next-pos (list next-pr next-pc))

           (when (and (valid? next-pr next-pc)
                      (not (and (= next-pr box-r) (= next-pc box-c)))
                      (not (set-contains? player-visited next-pos)))
             (when (and (= next-pr target-pr) (= next-pc target-pc))
               (values #t))

             (queue-add! player-q next-pos)
             (set! player-visited (set-add player-visited next-pos))))
         (loop))))
    )

  (define push-dirs '((-1 0 1 0)
                      (1 0 -1 0)
                      (0 -1 0 1)
                      (0 1 0 -1)))

  (define q (make-queue))
  (define visited (set))

  (queue-add! q (list initial-br initial-bc initial-pr initial-pc 0))
  (set! visited (set-add visited (list initial-br initial-bc initial-pr initial-pc)))

  (let loop ()
    (cond
      ((queue-empty? q) -1)
      (else
       (define current-state (queue-remove! q))
       (define br (list-ref current-state 0))
       (define bc (list-ref current-state 1))
       (define pr (list-ref current-state 2))
       (define pc (list-ref current-state 3))
       (define pushes (list-ref current-state 4))

       (when (and (= br target-r) (= bc target-c))
         (values pushes))

       (for ([dir push-dirs])
         (define box-dr (list-ref dir 0))
         (define box-dc (list-ref dir 1))
         (define player-req-dr (list-ref dir 2))
         (define player-req-dc (list-ref dir 3))

         (define next-br (+ br box-dr))
         (define next-bc (+ bc box-dc))
         (define player-target-pr (+ br player-req-dr))
         (define player-target-pc (+ bc player-req-dc))

         (when (valid? next-br next-bc)
           (when (can-player-reach? pr pc player-target-pr player-target-pc next-br next-bc)
             (define new-player-r br)
             (define new-player-c bc)
             (define new-state (list next-br next-bc new-player-r new-player-c))

             (when (not (set-contains? visited new-state))
               (set! visited (set-add visited new-state))
               (queue-add! q (list next-br next-bc new-player-r new-player-c (+ pushes 1)))))))
       (loop))))
  )